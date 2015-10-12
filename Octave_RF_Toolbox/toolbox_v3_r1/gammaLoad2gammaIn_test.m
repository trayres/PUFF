%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function gammaLoad2gammaIn_test()

% Inputs
gamma_load_mag = 0.3;
gamma_load_ang = 80;
s = [ptor(0.69,-78),ptor(0.033,41.4);ptor(5.67,123),ptor(0.84,-25)];

% Expected/Correct values
answer_mag = 0.74871;
answer_ang = -79.988;

% Calculate input reflection coef
[gamma_in_mag,gamma_in_ang] = gammaLoad2gammaIn(s,gamma_load_mag,gamma_load_ang);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected mag: ',num2str(answer_mag),'\n']); 
fprintf(['Returned mag: ',num2str(gamma_in_mag),'\n']);
fprintf(['Expected ang: ',num2str(answer_ang),'\n']); 
fprintf(['Returned ang: ',num2str(gamma_in_ang),'\n']);
fprintf('\n');

end%function


