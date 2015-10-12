%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 9/7/13
%%%% Octave tested: 9/7/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function saveMdf_test()

% Inputs
output_loc1 = 'ExampleDataFiles/saveMdf_ExData_noIndVar.mdf';
output_loc2 = 'ExampleDataFiles/saveMdf_ExData_withIndVar.mdf';
data = [1,2,3;4,5,6;7,8,9;1,2,3;4,5,6]
var_names = {['column_1'],['column_2'],['column_3']};
comments = {['comment_1'],['comment_2'],['comment_3']};
sweep_name = 'DSCRDATA';
indep_col1 = 0;
indep_col2 = 1;

% Create MDF with NO independent variable
saveMdf(output_loc1,data,var_names,comments,sweep_name,indep_col1);

% Create MDF split by independent variable
saveMdf(output_loc2,data,var_names,comments,sweep_name,indep_col2);

% Print results
fprintf('\n');
fprintf('...Verify the above data is found in the following two files\n');
fprintf('...one split up by column 1 and one that is not\n');
output_loc1
output_loc2
fprintf('\n');

end%function
