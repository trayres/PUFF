%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Calculate Stability parameters - k,delta,u
%%%%
%%%% Unconditionally stable if.....
%%%%	[ k>1 & delta<1 ] or [ u>1 ]
%%%%
%%%% Input:
%%%%	s =
%%%%	[s11rect, s12rect ;
%%%% 	 s21rect, s22rect ]
%%%%
%%%% Usage:
%%%%	[k,delta,u] = testStability(s)
%%%%
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% testStability.m
%%%% Last Modified: 6/14/12
%%%% Octave tested: 8/19/12
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [k,delta,u] = testStability(s)

%---------------------------------------------------------
% Split matrix into variables
%
s11 = s(1,1);
s21 = s(2,1);
s12 = s(1,2);
s22 = s(2,2);
magS11 = abs(s11);
magS21 = abs(s21);		% not used
magS12 = abs(s12);		% not used
magS22 = abs(s22);
%fprintf('\n');

%---------------------------------------------------------
% Stability calculations (pozar p.545)
%
delta = (s11*s22)-(s12*s21);
magdelta = abs(delta);	
angdelta = angle(delta)*(180/pi);					% not used
%delta2 = (magS11*magS22)+1-(0.5*((magS11)^2))-(0.5*((magS22)^2)); 	% (Pozar p.547)
%delta3 = 1-(0.5*(((magS11)^2)-((magS22)^2)));				% (Pozar p.547)	
k = (1-((magS11)^2)-((magS22)^2)+((magdelta)^2))/(2*abs(s12*s21));
u = (1-((magS11)^2))/(abs(s22-(delta*conj(s11)))+abs(s12*s21));

end%function
