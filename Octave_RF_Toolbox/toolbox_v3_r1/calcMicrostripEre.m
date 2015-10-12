%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Calculate the epsilon effective of a microstrip line
%%%% - Intended to be called from the function calcMicrostripMenu.m
%%%%
%%%% Input:	
%%%% - boardspecs: structure containing the following variables..... 
%%%% boardspecs.t
%%%% boardspecs.h
%%%% boardspecs.Er
%%%% boardspecs.W
%%%%	
%%%% Output:
%%%% - Ere: Epsilon effective (scalar number)
%%%%	
%%%% Usage:
%%%% boardspecs.t = 0.0078e-3;  % conductor thickness
%%%% boardspecs.h = 0.787e-3;   % board height
%%%% boardspecs.Er = 2.2;	% epsilon relative
%%%% boardspecs.W = 2.14e-3;	% width
%%%% Ere = calcMicrostripEre(boardspecs)
%%%%	
%%%% Primary reference: Andrei, p.149
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% calcMicrostripEre.m
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Ere = calcMicrostripEre(boardspecs)

%-------------------------------------
% Inputs - Board properties
%
t = boardspecs.t; 				% m
h = boardspecs.h; 				% m
Er = boardspecs.Er;				% epsilon relative (permitivity)
W = boardspecs.W; 				% m

%-------------------------------------
% Constants
%
c = 299792458;					% speed of light

%-------------------------------------
% Calc Er effective
%
a1 = ((Er+1)/2);				% Equation broken into sections
a2 = (((Er-1)/2)*(1/sqrt(1+((12*h)/W))));	% to make things easier
a3 = (((Er-1)/4.6)*(t/h)*sqrt(h/W));		%
Ere = a1+a2-a3;					%

end%function



