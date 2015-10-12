%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function gamma2rl2vswr_test()

% Inputs
test1_type = 'gamma';
test1_val = 0.3333;
test2_type = 'RL';
test2_val = 9.5511;
test3_type = 'vswr';
test3_val = 2;

% Expected/Correct values
answer1_gamma = 0.3333;
answer1_RL = 9.5511;
answer1_vswr = 2;
answer2_gamma = 0.3333;
answer2_RL = 2;
answer2_vswr = 2;
answer3_gamma = 0.3333;
answer3_RL = 2;
answer3_vswr = 2;

% Calculate with function
[gamma1,RL1,vswr1] = gamma2rl2vswr(test1_type,test1_val);
[gamma2,RL2,vswr2] = gamma2rl2vswr(test2_type,test2_val);
[gamma3,RL3,vswr3] = gamma2rl2vswr(test3_type,test3_val);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf('...Gamma\n');
fprintf(['Expected: ',num2str(answer1_gamma),'\n']); 
fprintf(['Returned: ',num2str(gamma1),'\n']);
fprintf(['Returned: ',num2str(gamma2),'\n']);
fprintf(['Returned: ',num2str(gamma3),'\n']);
fprintf('...RL\n');
fprintf(['Expected: ',num2str(answer1_RL),'\n']); 
fprintf(['Returned: ',num2str(RL1),'\n']);
fprintf(['Returned: ',num2str(RL2),'\n']);
fprintf(['Returned: ',num2str(RL3),'\n']);
fprintf('...vswr\n');
fprintf(['Expected: ',num2str(answer1_vswr),'\n']); 
fprintf(['Returned: ',num2str(vswr1),'\n']);
fprintf(['Returned: ',num2str(vswr2),'\n']);
fprintf(['Returned: ',num2str(vswr3),'\n']);
fprintf('\n');

% Print lookup table
fprintf('\n');
fprintf('...Verify lookup table......\n');
[gamma,RL,vswr] = gamma2rl2vswr;
fprintf('\n');

end%function
