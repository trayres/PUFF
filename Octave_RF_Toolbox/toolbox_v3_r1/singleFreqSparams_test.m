%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested:
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function singleFreqSparams_test()

% Inputs
% s2p filename, frequency in units that match s2p file
filename = "example3data.s2p";
freq = 3.0;

% Import s-parameter data from .s2p file
sparams = importS2P(filename);

% Find s-parameters at the desired frequency
% Create 2x2 s-parameter matrix (rectangular form)
s = singleFreqSparams(sparams,freq);

% convert back to polar form so it can be compared with original
row(1) = freq;
[row(2),row(3)] = rtop(s(1,1));
[row(4),row(5)] = rtop(s(2,1));
[row(6),row(7)] = rtop(s(1,2));
[row(8),row(9)] = rtop(s(2,2));

% print check dialog to terminal
fprintf('\n');
fprintf(['This row should match the [ ',num2str(freq),' ] freq row in complete matrix\n']);
row
fprintf('\n');
sparams
fprintf('\n');

end%function
