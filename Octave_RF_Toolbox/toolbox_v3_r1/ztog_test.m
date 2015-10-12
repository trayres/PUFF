%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ztog_test()

% Inputs
Z1 = 40+20i
Zo = 50
z1 = Z1/Zo;

% Expected/Correct values
answer_mag = 0.24254;
answer_ang = 104.04;

% Calculate with function
[g1_mag,g1_ang] = ztog(Z1,Zo);
[g1_mag_new,g1_ang_new] = ztog(z1);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_mag),'\n']); 
fprintf(['Returned: ',num2str(g1_mag),'\n']);
fprintf(['Returned: ',num2str(g1_mag_new),'\n']);
fprintf(['Expected: ',num2str(answer_ang),'\n']); 
fprintf(['Returned: ',num2str(g1_ang),'\n']);
fprintf(['Returned: ',num2str(g1_ang_new),'\n']);
fprintf('\n');

end%function
