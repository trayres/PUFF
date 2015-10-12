%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% 
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcMicrostripL_test()

% Inputs
boardspecs.f = 2.14e9;	% frequency
boardspecs.EL = 90;	% electrical length
boardspecs.Ere = 2.4;	% epsilon effective

% Expected/Correct values
answer_L = 0.022607;

% Calculate with function
L = calcMicrostripL(boardspecs);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_L),'\n']); 
fprintf(['Returned: ',num2str(L),'\n']);
fprintf('\n');

end%function



