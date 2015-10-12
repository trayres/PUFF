%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function getFreqDistribution_test()

% Inputs
frequency_col = [2.8; 2.8; 2.8; 3.0; 3.0; 3.0; 3.2; 3.2; 3.2]

% Expected/Correct values
Expected_freq_dist = [2.8, 1, 3, 3;3.0, 4, 6, 3;3.2, 7, 9, 3];

% Calculate with function
Returned_freq_dist = getFreqDistribution(frequency_col);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned matricies are the same\n');
Expected_freq_dist
Returned_freq_dist
fprintf('\n');

end%function
