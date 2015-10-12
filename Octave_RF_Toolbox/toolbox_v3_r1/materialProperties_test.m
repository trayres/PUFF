%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function materialProperties_test()

% Calculate with function
copper_cond = materialProperties('Copper','cond');

% Expected/Correct value
answer_cond = 5.96e7;

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_cond),'\n']); 
fprintf(['Returned: ',num2str(copper_cond),'\n']);
fprintf('\n');

end%function
