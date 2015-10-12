%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcMicrostripEL_test()

% Inputs
boardspecs.f = 2.14e9;	% frequency
boardspecs.L = 16e-3;	% length
boardspecs.Ere = 2.4;	% epsilon effective

% Expected/Correct values
answer_EL = 63.697;

% Calculate with function
EL = calcMicrostripEL(boardspecs);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_EL),'\n']); 
fprintf(['Returned: ',num2str(EL),'\n']);
fprintf('\n');

end%function
