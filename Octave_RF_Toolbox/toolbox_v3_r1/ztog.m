%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert impedance to reflection coeff.
%%%%
%%%% Input:	
%%%% ZL - load impedance
%%%% zL - load impedance (normalized)
%%%% Zo - characteristic impedance
%%%%
%%%% Output:
%%%% reflmag = reflection coeff. magnitude
%%%% reflang = reflection coeff. angle
%%%%
%%%% Usage:
%%%% 1 Argument  
%%%% -> assumed to be normalized impedance
%%%% -> [reflmag,reflang] = ztog(zL)
%%%%
%%%% 2 Arguments 
%%%% -> first argument is assumed to be an unnomalized impedance
%%%% -> second argument is assumed to be the characteristic impedance
%%%% -> [reflmag,reflang] = ztog(ZL,Zo)
%%%%
%%%% Example:
%%%% Zo = 50;
%%%% ZL = 20+10i;
%%%% [reflmag,reflang] = ztog(ZL,Zo)
%%%% zL = ZL/Zo;
%%%% [reflmag,reflang] = ztog(zL)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% gtoz.m
%%%% Last Edited: 6/14/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [reflmag,reflang] = ztog(varargin)

%---------------------------------------------------------
% Inputs
%
switch (nargin)
case 1
	zL = varargin{1};
case 2
	ZL = varargin{1};
	Zo = varargin{2};
	zL = ZL/Zo;
otherwise
	warning('incorrect number of arguments to function ztog.m')
	warning('Usage:')
	warning('	[reflmag,reflang] = ztog(ZL,Zo)')
	warning('	[reflmag,reflang] = ztog(zL)')
end%switch

%---------------------------------------------------------
% Calculation
%
refl = (zL-1)/(zL+1);
reflmag = abs(refl);
reflang = angle(refl)*(180/pi);

end%function




