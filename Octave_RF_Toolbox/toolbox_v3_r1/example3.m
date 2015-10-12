%%%%%%%%%%%%%%%%%%% START example3.m %%%%%%%%%%%%%%%%%%%
% Import s-parameter data from .s2p file
% Find s-parameters at a single frequency
%
% curtis | creatingrf[@]gmail.com
% Last Edited: 6/15/12
% Octave tested: 9/7/13
% Matlab tested: 6/15/12
function example3()

% Inputs
% s2p filename, frequency in GHz
filename = 'example3data.s2p'
freq = 3.0

% Import s-parameter data from .s2p file
sparams = importS2P(filename)

% Find s-parameters at the desired frequency
% Create 2x2 s-parameter matrix (rectangular form)
s = singleFreqSparams(sparams,freq)

end%function
%%%%%%%%%%%%%%%%%%% END example3.m %%%%%%%%%%%%%%%%%%%
