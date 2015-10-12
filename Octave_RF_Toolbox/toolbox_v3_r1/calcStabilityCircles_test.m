%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcStabilityCircles_test()

% Inputs
s(1,1) = ptor(0.502,-172.55);
s(2,1) = ptor(4.693,57.94);
s(1,2) = ptor(0.092,11.46);
s(2,2) = ptor(0.371,-100.53);

% Expected/Correct values
answer_Cs_mag = 3.1891;
answer_Cs_ang = 177.26;
answer_Rs = 2.3431;
answer_CL_mag = 6.9892;
answer_CL_ang = 108.20;
answer_RL = 6.1764;

% Calculate with function
[Cs_mag,Cs_ang,Rs,CL_mag,CL_ang,RL] = calcStabilityCircles(s);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf('...Cs_mag\n');
fprintf(['Expected: ',num2str(answer_Cs_mag),'\n']); 
fprintf(['Returned: ',num2str(Cs_mag),'\n']);
fprintf('...Cs_ang\n');
fprintf(['Expected: ',num2str(answer_Cs_ang),'\n']); 
fprintf(['Returned: ',num2str(Cs_ang),'\n']);
fprintf('...Rs\n');
fprintf(['Expected: ',num2str(answer_Rs),'\n']); 
fprintf(['Returned: ',num2str(Rs),'\n']);
fprintf('...CL_mag\n');
fprintf(['Expected: ',num2str(answer_CL_mag),'\n']); 
fprintf(['Returned: ',num2str(CL_mag),'\n']);
fprintf('...CL_ang\n');
fprintf(['Expected: ',num2str(answer_CL_ang),'\n']); 
fprintf(['Returned: ',num2str(CL_ang),'\n']);
fprintf('...RL\n');
fprintf(['Expected: ',num2str(answer_RL),'\n']); 
fprintf(['Returned: ',num2str(RL),'\n']);
fprintf('\n');

end%function
