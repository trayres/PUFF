%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function listDir_test()

% Inputs
folder_name = './'
%folder_name = './ExampleDataFiles'
%folder_name = 'ExampleDataFiles'

% Expected/Correct values
answer_db = 6;

% Calculate with function
[dir_list] = listDir()
[dir_list] = listDir(folder_name)

% Print results
fprintf('\n');
fprintf('...Verify the expected and returned values are the same\n');
%fprintf(['Expected: ',num2str(answer_db),'\n']); 
%fprintf(['Returned: ',num2str(db),'\n']);
fprintf('\n');

end%function
