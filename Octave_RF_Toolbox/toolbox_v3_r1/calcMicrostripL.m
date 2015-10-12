%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Calculate Microstrip length 
%%%% given Epsilon Effective, Electrical Length, and frequency
%%%% - Intended to be called from the function calcMicrostripMenu.m
%%%%
%%%% Input:	
%%%% - boardspecs: Structure containing the following variables.....
%%%% boardspecs.Ere
%%%% boardspecs.EL
%%%% boardspecs.f
%%%%	
%%%% Output:
%%%% - L: physical length in meters (scalar number)
%%%%	
%%%% Usage:
%%%% boardspecs.f = 2.14e9;	% frequency
%%%% boardspecs.EL = 90;	% electrical length
%%%% boardspecs.Ere = 2.4;	% epsilon effective
%%%% L = calcMicrostripL(boardspecs)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% calcMicrostripL.m
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function L = calcMicrostripL(boardspecs)

%-------------------------------------
% Inputs
%
Ere = boardspecs.Ere;				% epsilon effective
EL = boardspecs.EL;				% electrical length in degrees
f = boardspecs.f;				% frequency

%-------------------------------------
% Constants
%
c = 299792458;					% speed of light

%-------------------------------------
% Calculate the wavelength in the guide
%
wavelength_o = c/f;				% wavelength in air (m)
wavelength_g = wavelength_o/sqrt(Ere);		% wavelength in the guide (m)

%-------------------------------------
% Calculate L
%
EL_ratio = EL/360;				% electrical length in ratio form
L = EL_ratio*wavelength_g;			% physical length in meters

end%function






