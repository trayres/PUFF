%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function testStability_test()

% S-parameters for test case
s(1,1) = ptor(0.502,-172.55);
s(2,1) = ptor(4.693,57.94);
s(1,2) = ptor(0.092,11.46);
s(2,2) = ptor(0.371,-100.53);

% Expected/Correct values
answer_k = 0.78527;
answer_delta = -0.14190-0.21818i;
answer_u = 0.81275;

% Calculate values from function
[k,delta,u] = testStability(s)

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_k),' \nReturned: ',num2str(k),'\n']);
fprintf(['Expected: ',num2str(answer_delta),' \nReturned: ',num2str(delta),'\n']);
fprintf(['Expected: ',num2str(answer_u),' \nReturned: ',num2str(u),'\n']);
fprintf('\n');

end%function
