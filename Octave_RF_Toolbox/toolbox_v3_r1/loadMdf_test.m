%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 10/6/13
%%%% Octave tested: 10/6/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function loadMdf_test()

% Inputs
foldername = 'ExampleDataFiles/';
filename = 'saveMdf_ExData_noIndVar.mdf';
%filename = 'saveMdf_ExData_withIndVar.mdf';

% Expected/Correct values
answer_A = 0;
answer_B = 0;

% Calculate with function
[data,column_headings] = loadMdf(foldername,filename);

% Print results
fprintf('\n');
column_headings
data
fprintf('\n');
fprintf('...Verify the above data matches the following file\n');
fprintf(['...[ ',foldername,filename,' ]\n']);
%fprintf(['Expected z: ',num2str(answer_A),'\n']); 
%fprintf(['Returned z: ',num2str(A),'\n']);
%fprintf(['Expected Z: ',num2str(answer_B),'\n']); 
%fprintf(['Returned Z: ',num2str(B),'\n']);
fprintf('\n');

end%function




