%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Calculate the electrical length of a microstrip line
%%%% given epsilon effective, physical length, and frequency
%%%% - Intended to be called from the function calcMicrostripMenu.m
%%%%
%%%% Input:	
%%%% - boardspecs: Structure containing the following variables.....
%%%% boardspecs.f
%%%% boardspecs.Ere
%%%% boardspecs.L
%%%%	
%%%% Output:
%%%% - EL: Electrical Length in Degrees (scalar number)
%%%%	
%%%% Usage:
%%%% boardspecs.f = 2.14e9;	% frequency
%%%% boardspecs.L = 16e-3;	% length
%%%% boardspecs.Ere = 2.4;	% epsilon effective
%%%% EL = calcMicrostripEL(boardspecs)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% calcMicrostripEL.m
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function EL = calcMicrostripEL(boardspecs)

%-------------------------------------
% Inputs
%
f = boardspecs.f;					% frequency
Ere = boardspecs.Ere;					% epsilon effective
L = boardspecs.L;					% physical length in meters
c = 299792458;						% speed of light in air

%-------------------------------------
% Calculate the guide wavelength, given Ere and f
%
wavelength_o = c/f;					% wavelength in air (m)
wavelength_g = wavelength_o/sqrt(Ere);  		% wavelength in the guide (m)

%-------------------------------------
% Calculate the electrical length given the length in meters
%
EL_ratio = L/wavelength_g;				% electrical length in ratio form
EL = EL_ratio*(360);					% electrical length in degrees

end%function
