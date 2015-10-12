%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function db2r_test()

% Inputs
db = 6

% Expected/Correct values
answer_ratio = 4;

% Calculate with function
ratio = db2r(db);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected ratio: ',num2str(answer_ratio),'\n']); 
fprintf(['Returned ratio: ',num2str(ratio),'\n']);
fprintf('\n');

end%function
