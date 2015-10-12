%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function gtoz_test()

% Inputs
reflmag = 0.4;
reflang = 60;
Zo = 50;

% Expected/Correct values
answer_z = 1.10526+0.911606i;
answer_Z = 55.2632+45.5803i;

% Calculate with function
[z1,Z1] = gtoz(reflmag,reflang,Zo);
z2 = gtoz(reflmag,reflang,Zo);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected z: ',num2str(answer_z),'\n']); 
fprintf(['Returned z: ',num2str(z1),'\n']);
fprintf(['Returned z: ',num2str(z2),'\n']);
fprintf(['Expected Z: ',num2str(answer_Z),'\n']); 
fprintf(['Returned Z: ',num2str(Z1),'\n']);
fprintf('\n');

end%function
