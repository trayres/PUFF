%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Plot a single point on a smith chart
%%%%	- Smith chart should already be created using scCreate
%%%%	- Impedance must be normalized
%%%%
%%%% Assumes: 	
%%%%	1 argument in --> Plot Impedance (normalized)
%%%%	2 arguments in -> Plot Reflection Coeff.
%%%%
%%%% Usage:	
%%%%	scAddPoint(rectZ) ---> Plot Impedance (normalized)
%%%%	scAddPoint(mag,ang) -> Plot Reflection Coeff.
%%%%
%%%% Example:	
%%%%	scAddPoint(2+1i) ----> Plot Impedance (normalized)
%%%%	scAddPoint(0.6,110) -> Plot Reflection Coeff.
%%%%
%%%% %%%% Need to add option to select color
%%%% %%%% Need to fix legend issue after recent update
%%%% curtis | creatingrf[@]gmail.com
%%%% scAddPoint.m
%%%% Last modified: 6/14/12
%%%% Octave tested: 8/19/12
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function scAddPoint(varargin)

num_argin = nargin;

color_options = ['k','r','g','b','m','c'];	% select random color
random_num = round(5*rand)+1;			%
random_color = color_options(random_num);	%

point_type = '*';				% init point properties
point_color = random_color;			%
plot_point = 0+0i;				%

if(num_argin==1)				% if input is impedance
	a = varargin{1};  			% a=r+xi
	plot_point = (a-1)/(a+1);		% convert to refl coef in rect form
	label = num2str(a);
elseif(num_argin==2)				% if input is refl coef
	a1 = varargin{1};   			% refl magnitude
	a2 = varargin{2};   			% refl angle
	plot_point = ptor(a1,a2);		% convert to rect coord.
	label = [num2str(a1),' L',num2str(a2)];
else
	fprintf('Inproper call to scAddPoint\n');
	fprintf('Usage: scAddPoint(R+Xi) or scAddPoint(mag(refl),ang(refl))\n');
end%if

plot(real(plot_point),imag(plot_point),[point_type,point_color]);
%legend(label);



end%function



