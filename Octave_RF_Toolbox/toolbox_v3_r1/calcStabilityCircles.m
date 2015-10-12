%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Find location of stability circles
%%%% 	- Followup with scCreate.m & scAddCircle.m to plot circles
%%%%	- Used in plotStabilityCircles.m
%%%%
%%%% Output:
%%%%	Cs - Center of Input stability circle (polar form)
%%%%	Rs - Radius of Input stability circle (scalar)
%%%%	CL - Center of Output stability circle (polar form)
%%%%	Rs - Radius of Output stability circle (scalar)
%%%% 
%%%% Input:
%%%%	s = 
%%%% 	[s11rect, s12rect ;
%%%% 	 s21rect, s22rect ]
%%%%	
%%%% Usage: 
%%%% 	[Cs_mag,Cs_ang,Rs,CL_mag,CL_ang,RL] = calcStabilityCircles(s)
%%%% 
%%%%
%%%% curtis [creatingrf at gmail.com]
%%%% calcStabilityCircles.m
%%%% Last Edited: 6/15/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [Cs_mag,Cs_ang,Rs,CL_mag,CL_ang,RL] = calcStabilityCircles(s)

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
%fprintf("\n");

%---------------------------------------------------------
% Stability calculations (pozar p.545)
% Need delta and |delta| to calc circles
%
delta = (s11*s22)-(s12*s21);
magdelta = abs(delta);	
angdelta = angle(delta)*(180/pi);					% not used
%delta2 = (magS11*magS22)+1-(0.5*((magS11)^2))-(0.5*((magS22)^2)); 	% (Pozar p.547)
%delta3 = 1-(0.5*(((magS11)^2)-((magS22)^2)));				% (Pozar p.547)

%---------------------------------------------------------
% Calc center location and radius (pozar p.548)
%
CL = (conj(s22-(delta*conj(s11))))/(((magS22)^2)-((magdelta)^2));
	CL_mag = abs(CL);
	CL_ang = angle(CL)*(180/pi);
	%CL_x = real(CL);
	%CL_y = imag(CL);
RL = (abs(s12*s21))/(((magS22)^2)-((magdelta)^2));
	%RL_mag = abs(RL)						% should be equal to Rs
	%RL_ang = angle(RL)*(180/pi)					% should be 0
Cs = (conj(s11-(delta*conj(s22))))/(((magS11)^2)-((magdelta)^2));
	Cs_mag = abs(Cs);
	Cs_ang = angle(Cs)*(180/pi);
	%Cs_x = real(Cs);
	%Cs_y = imag(Cs);
Rs = (abs(s12*s21))/(((magS11)^2)-((magdelta)^2));
	%Rs_mag = abs(Rs)						% should be equal to Rs
	%Rs_ang = angle(Rs)*(180/pi)					% should be 0


end%function




