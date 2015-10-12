%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcMicrostripEre_test()

% Inputs
boardspecs.t = 0.0078e-3; % conductor thickness
boardspecs.h = 0.787e-3;  % board height
boardspecs.Er = 2.2;	  % epsilon relative
boardspecs.W = 2.14e-3;	  % width

% Expected/Correct values
answer_Ere = 1.8563;

% Calculate with function
Ere = calcMicrostripEre(boardspecs);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_Ere),'\n']); 
fprintf(['Returned: ',num2str(Ere),'\n']);
fprintf('\n');

end%function
