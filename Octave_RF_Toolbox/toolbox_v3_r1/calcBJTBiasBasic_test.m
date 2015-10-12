%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/1/13
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcBJTBiasBasic_test()

% Inputs
Vcc = 4;
Vceq = 2;
Icq = 10*(1e-3);
Vbeq = 0.84;
Bdc = 280;

% Expected/Correct values
answer_Rb = 88480;
answer_Rc = 200;
answer_Ic_sat = 0.020000;
answer_Vce_off = 4;

% Calculate with function
calcBJTBiasBasic();
[Rb,Rc,Ic_sat,Vce_off] = calcBJTBiasBasic(Vcc,Vceq,Icq,Vbeq,Bdc);

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf('...and they match the values above.\n');
fprintf('...Assuming script defaults have not been changed\n');
fprintf('----[ Rb ] - Resistor at base\n');
fprintf(['Expected ratio: ',num2str(answer_Rb),'\n']); 
fprintf(['Returned ratio: ',num2str(Rb),'\n']);
fprintf('----[ Rc ] - Resistor at collector\n');
fprintf(['Expected ratio: ',num2str(answer_Rc),'\n']); 
fprintf(['Returned ratio: ',num2str(Rc),'\n']);
fprintf('----[ Ic_sat ] - Load line Y intercept\n');
fprintf(['Expected ratio: ',num2str(answer_Ic_sat),'\n']); 
fprintf(['Returned ratio: ',num2str(Ic_sat),'\n']);
fprintf('----[ Vce_off ] - Load line X intercept\n');
fprintf(['Expected ratio: ',num2str(answer_Vce_off),'\n']); 
fprintf(['Returned ratio: ',num2str(Vce_off),'\n']);
fprintf('\n');

end%function
