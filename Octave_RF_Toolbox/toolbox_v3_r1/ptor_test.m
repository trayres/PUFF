%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ptor_test()

% Inputs
mag = 44.721;
ang = 26.565;

% Expected/Correct values
answer_rect = 40+20i;

% Calculate with function
rect = ptor(mag,ang);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_rect),'\n']); 
fprintf(['Returned: ',num2str(rect),'\n']);
fprintf('\n');

end%function
