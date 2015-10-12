%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function rtop_test()

% Inputs
ZL = 40+20i

% Expected/Correct values
answer_mag = 44.721;
answer_ang = 26.565;

% Calculate with function
[mag,ang] = rtop(ZL);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_mag),'\n']); 
fprintf(['Returned: ',num2str(mag),'\n']);
fprintf(['Expected: ',num2str(answer_ang),'\n']); 
fprintf(['Returned: ',num2str(ang),'\n']);
fprintf('\n');

end%function
