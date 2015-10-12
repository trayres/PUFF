%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert reflection coeff. to impedance
%%%%
%%%% Input:	
%%%% 	reflmag - Reflection coeff. magnitude
%%%% 	reflang - Reflection coeff. angle in degrees
%%%% 	Zo - Characteristic impedance
%%%% Output:
%%%%	Z - impedance
%%%%	z - normalized impedance (for smith chart)
%%%% Usage:
%%%%	[z,Z] = gtoz(reflmag,reflang,Zo)
%%%% 	z = gtoz(reflmag,reflang,Zo)
%%%%
%%%% To do:
%%%% -make it work without Zo input, to just output z, not Z
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% gtoz.m
%%%% Last Edited: 5/5/11
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [z,Z] = gtoz(refl_mag,refl_ang,Zo)
% convert to rectangular coordinates
refl_rect = ptor(refl_mag,refl_ang);

% convert refl coeff. to normalized impedance
z = (1+refl_rect)/(1-refl_rect);

% un-normalized impedance
Z = z*Zo;

end%function




