%%%%%%%%%%%%%%%%%%% START example4.m %%%%%%%%%%%%%%%%%%%
% Plot the input and output stability circles for a given s-parameter matrix
% Could also plot stability circles for a range of frequencies from an s2p file
% by using: plotStabilityCircles(folder,filename,f_min,f_max)
%
% curtis  | creatingrf[@]gmail.com
% Last Edited: 6/15/12
% Octave tested: 9/7/13
% Matlab tested: 6/15/12
function example4()

% Inputs
% Store s-parameters in 2x2 matrix called "s"
% Converting to rectanguar form allows parameters
% to be stored in 2x2 matrix instead of 2x4 matrix
s(1,1) = ptor(0.502,-172.55);
s(2,1) = ptor(4.693,57.94);
s(1,2) = ptor(0.092,11.46);
s(2,2) = ptor(0.371,-100.53);

% Plot input and output stability circles
plotStabilityCircles(s)

end%function
%%%%%%%%%%%%%%%%%%% END example4.m %%%%%%%%%%%%%%%%%%%
