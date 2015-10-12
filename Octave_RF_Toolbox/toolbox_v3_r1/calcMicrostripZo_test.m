%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% 
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcMicrostripZo_test()

% Inputs
boardspecs.t = 0.0078e-3;  % conductor thickness
boardspecs.h = 0.787e-3;   % board height
boardspecs.Er = 2.2;	   % epsilon relative
boardspecs.W = 2.14e-3;	   % width
boardspecs.Ere = 2.4;	   % epsilon effective

% Expected/Correct values
answer_Zo = 47.787;

% Calculate with function
Zo = calcMicrostripZo(boardspecs);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_Zo),'\n']); 
fprintf(['Returned: ',num2str(Zo),'\n']);
fprintf('\n');

end%function



