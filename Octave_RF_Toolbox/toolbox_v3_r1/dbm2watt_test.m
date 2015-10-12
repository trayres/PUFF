%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function dbm2watt_test()

% Inputs
dbm = 30

% Expected/Correct values
answer_watt = 1;

% Calculate with function
watt = dbm2watt(dbm);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected ratio: ',num2str(answer_watt),'\n']); 
fprintf(['Returned ratio: ',num2str(watt),'\n']);
fprintf('\n');

end%function
