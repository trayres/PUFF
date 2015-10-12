%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/7/13
%%%% Octave tested: 9/7/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcCascadedNoise_test()

% Inputs
gain_lineup_db = [-3,-4,15,6,-4];
nf_lineup_db = [3,4,4,9,4];

% Expected/Correct values
answer_NF_dB = 11.383;

% Calculate with function
NF_dB = calcCascadedNoise(gain_lineup_db,nf_lineup_db);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected ratio: ',num2str(answer_NF_dB),'\n']); 
fprintf(['Returned ratio: ',num2str(NF_dB),'\n']);
fprintf('\n');

end%function
