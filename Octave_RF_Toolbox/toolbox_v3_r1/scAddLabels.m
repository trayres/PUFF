%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Label smith chart circles and arcs
%%%% - Used in scCreate.m
%%%% - Not very useful by itself
%%%%
%%%% Input:
%%%% - circles: vector of z-chart circle values
%%%% - arcs: vector of z-chart arc values
%%%%
%%%% Usage: 
%%%% scAddLabels(circles,arcs)
%%%%
%%%% Example:
%%%% circles = [0.2, 0.6, 1, 2];
%%%% arcs =    [0.2, 0.6, 1, 2];
%%%% scAddLabels(circles,arcs)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% scAddLabels.m
%%%% Last modified: 6/14/12
%%%% Octave tested: 
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function scAddLabels(circles,arcs)

for R = circles 						% for each circle value
re_axis = R/(1+R);						%
im_axis = 0;							%
radius = 1/(1+R);						%
text(re_axis-radius,im_axis-0.02,num2str(R))			% add circle label
end								%

for X = arcs							% for each arc value
label_loc = ((X*i)-1)/((X*i)+1);				% convert to refl coef
text(real(label_loc)+0.01,imag(label_loc),num2str(X))		% add upper arc label
text(real(label_loc)+0.01,(-1)*imag(label_loc),num2str(X))	% add arc label
end								%

end
