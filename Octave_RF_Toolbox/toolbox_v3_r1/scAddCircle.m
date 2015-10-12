%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Add circle to a smith chart
%%%% - Smith chart should already be created using scCreate.m
%%%%
%%%% Input:
%%%% - center_mag --- distance from center of smith chart (polar form)
%%%% - center_angle - degrees (polar form)
%%%% - radius ------- radius of circle (scalar)
%%%% - color -------- choose from 'k','r','g','b','m','c'
%%%%
%%%% Usage: 
%%%% scAddCircle(center_mag,center_angle,radius,color)
%%%%
%%%% Example:
%%%% scAddCircle(1.3,50,0.5,'g')
%%%% 
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% scAddCircle.m
%%%% Last modified: 6/14/12
%%%% Octave tested: 8/19/12
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function scAddCircle(c_mag,c_ang,radius,color)

%---------------------------------------------------------
% Convert inputs for plotting
%
center = ptor(c_mag,c_ang);				% center location (rect form)
re_axis = real(center);					% x-axis location
im_axis = imag(center);					% y-axis location
radius = radius;					% for easy future editing

%---------------------------------------------------------
% Circle Properties
%
color = color;						% for easy future editing

%---------------------------------------------------------
% vectors required to produce circles
%
t = [0:0.01:2*pi];					% resolution of circle
x = cos(t);
y = sin(t);

%---------------------------------------------------------
% Plot circle
%
plot(((x*radius)+re_axis),((y*radius)+im_axis),color)	% add circle
axis([-1,1,-1,1],'square')				% make plot square, not rectangle

end%endfunction




