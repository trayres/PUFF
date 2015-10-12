%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Get random color
%%%%	- intended for use with plot()
%%%%
%%%% Output:
%%%%	One of the following....
%%%%	['k','r','g','b','m','c']
%%%% Usage:
%%%%	color = getRandomColor
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% getRandomColor.m
%%%% Last Edited: 6/15/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function color = getRandomColor()

color_options = ['k','r','g','b','m','c'];	% color options
random_num = round(5*rand)+1;			% random number from 1 to 6
color = color_options(random_num);		% random color

end%function
