%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function importS2P_test()

% Inputs
% s2p filename, frequency in GHz
filename = 'example3data.s2p';
folder = './';

% Import s-parameter data from .s2p file
sparams = importS2P(filename);
[sparams,dataset2,sNp_format_info,comments] = importS2P(filename);
[sparams,dataset2,sNp_format_info,comments] = importS2P(folder,filename);

% Print results to be checked
fprintf('\n');
fprintf('...Verify what is printed matches what is in the file\n');
fprintf(['...Printing data from the file [ ',filename,' ]\n']);
comments
sNp_format_info
sparams
dataset2
fprintf('\n');

end%function
