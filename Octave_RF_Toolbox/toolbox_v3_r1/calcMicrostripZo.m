%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Calculate Impedance of Microstrip line
%%%% - Intended to be called from the function calcMicrostripMenu.m
%%%%
%%%% Input:	
%%%% - boardspecs: structure containing the following variables..... 
%%%% boardspecs.t
%%%% boardspecs.h
%%%% boardspecs.Er
%%%% boardspecs.W
%%%% boardspecs.Ere
%%%%	
%%%% Output:
%%%% - Zo: characteristic impedance of microstrip line (scalar number)
%%%%	
%%%% Usage:
%%%% boardspecs.t = 0.0078e-3;  % conductor thickness
%%%% boardspecs.h = 0.787e-3;   % board height
%%%% boardspecs.Er = 2.2;	% epsilon relative
%%%% boardspecs.W = 2.14e-3;	% width
%%%% boardspecs.Ere = 2.4;	% epsilon effective
%%%% Zo = calcMicrostripZo(boardspecs)
%%%%	
%%%% Primary reference: Andrei, p.149
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% calcMicrostripZo.m
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Zo = calcMicrostripZo(boardspecs)

%-------------------------------------
% Inputs - Board properties
%
t = boardspecs.t; 				% m
h = boardspecs.h; 				% m
Er = boardspecs.Er;				% epsilon relative (permitivity)
W = boardspecs.W; 				% m
Ere = boardspecs.Ere;				% epsilon effective

%-------------------------------------
% Initialize Variables
% Use: [ W, h, t ]
%
Zo = 1;  					% ohms
W_h = W/h;					% width/height ratio
t_h = t/h;					% thickness/height ratio

%-------------------------------------
% Calculate the change in width according to height 
% dW_h = dW/h
% Use: [ W_h, t, h, W ]
%
a1 = ((1.25/pi)*(t/h));

if(W_h <= (1/(2*pi)) )
	a2 = (1+log((4*pi*W)/t));
else
	a2 = (1+log((2*h)/t));
end%if

dW_h = a1*a2;

%-------------------------------------
% Calculate the effective width
% We = We/h * h
% Use: [ W, h, dW_h ]
%
We_h = (W/h)+(dW_h);
We = We_h*h;

%-------------------------------------
% Calc Zo
% Use: [ W_h, Ere, h, We ]
%
if(W_h <= 1)
	a1 = (60/sqrt(Ere));
	a2 = (((8*h)/We)+(We/(4*h)));
	Zo = a1*log(a2);
elseif(W_h >= 1)
	a1 = ((120*pi)/sqrt(Ere));
	a2 = ((We/h)+1.393+(0.667*log((We/h)+1.444)));
	Zo = a1*(1/a2);
else
	warning("something is wrong - calcMicrostrip")
end%if

%-------------------------------------
% Calc Zo assume t=0 (for check)
% Use: [ Er, h, W ]
%
Zo_check = ((120*pi)/sqrt(Er))*(h/W)*(1/(1+(1.735*(Er^(-0.0724))*((W/h)^(-0.836)))));

end%function





