%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/7/13
%%%% Octave tested: 9/7/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function importCsvColData_test()

% Inputs
foldername = 'ExampleDataFiles/';
filename = 'csv2mdf_ExData.csv';

% Expected/Correct values
answer_A = 0.8;
answer_B = 0.04;
answer_C = 'Vgs';

% Calculate with function
[data,titles] = importCsvColData(foldername,filename);
A = data(2,1);
B = data(7,3);
C = titles{1};


% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
fprintf(['Expected: ',num2str(answer_A),'\n']); 
fprintf(['Returned: ',num2str(A),'\n']);
fprintf(['Expected: ',num2str(answer_B),'\n']); 
fprintf(['Returned: ',num2str(B),'\n']);
fprintf(['Expected: ',answer_C,'\n']); 
fprintf(['Returned: ',C,'\n']);
fprintf('\n');

end%function
