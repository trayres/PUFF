%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert csv column data to mdf format
%%%% - csv file must only include numbers except for column headings
%%%% - column headings must be in row 1
%%%% - In excel, saveas comma-delimited (.csv), delete text delimiter
%%%% - ads can load mdf files with the DAQ component
%%%% - requires importCsvColData.m & saveMdf.m to be in matlab path
%%%%
%%%% Input:
%%%% Specify at the beginning of this script
%%%% - folder location
%%%% - file name of .csv file
%%%% - sweep name
%%%%
%%%% Outputs:
%%%% - Creates .mdf file
%%%%
%%%% Usage: 
%%%% 1) Create 3 column .csv file from excel or manually
%%%% 2) Save csv2mdf.m, importCsvColData.m, and saveMdf.m to same directory
%%%% 3) Specify .csv folder/file names inside of csv2mdf.m
%%%% 4) run csv2mdf.m
%%%%
%%%% Example: Convert IVdata.csv to IVdata.mdf
%%%% ---------IVdata.csv-----------
%%%% Vg,Vd,Id
%%%% -0.2,5,30
%%%% -0.2,6,32
%%%% 0.0,5,45
%%%% 0.0,6,48
%%%% ------------------------------
%%%%
%%%% ---------IVdata.mdf-----------
%%%% VAR Vgs=-0.2
%%%% BEGIN Swp1
%%%% % Vds,Id
%%%% 5,30
%%%% 6,32
%%%% END
%%%% 
%%%% BEGIN Swp1
%%%% VAR Vg=0.0
%%%% % Vd,Id
%%%% 5,45
%%%% 6,48
%%%% END
%%%% ------------------------------
%%%%
%%%% curtis [creatingrf at gmail.com]
%%%% csv2mdf.m
%%%% Last Edited: 8/1/12
%%%% Octave tested: 9/7/13
%%%% Matlab tested: 8/1/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function csv2mdf()

%----------------------------------------
% Inputs
%
folder = 'ExampleDataFiles/';
name = 'csv2mdf_ExData';
sweep_name = 'DCsweep';

%----------------------------------------
% Initialize
%
csv_loc = [folder,'/',name,'.csv'];
mdf_loc = [folder,'/',name,'.mdf'];
comments{1} = ['Folder: ',folder];
comments{2} = ['Filename: ',name];
comments{3} = ['Created: ',datestr(clock)];
comments{4} = ['~~~~~~~~~~~~~~~~~~~~~'];

%----------------------------------------
% import csv file
%
[data,titles] = importCsvColData(csv_loc);

%----------------------------------------
% Does user want to use an indep variable?
%
use_indep_var = useIndepVariable();
%use_indep_var = true;

%----------------------------------------
% Ask user to select column to use as indep variable
%
if(use_indep_var)
indep_col = selectIndepVariable(data,titles);
else
indep_col = 0;
end%if

%----------------------------------------
% Ask user to select indep variable
%
saveMdf(mdf_loc,data,titles,comments,sweep_name,indep_col)

end%function



function use_indep_var = useIndepVariable()

%----------------------------------------
% Initialize
%
use_indep_var_input = 'yes';
use_indep_var = true;
valid_input = false;

%----------------------------------------
% Ask until yes or no is entered
%
while(~valid_input)
use_indep_var_input = input('Split data using independent variable [yes/no]?..','s');
switch use_indep_var_input
    case 'yes'
        use_indep_var = true;
        valid_input = true;
    case 'no'
        use_indep_var = false;
        valid_input = true;
    otherwise
        fprintf('Invalid input. Enter yes or no\n');
end%switch
end%while
end%function



function indep_col = selectIndepVariable(data,titles)

%----------------------------------------
% Initialize
%
num_cols = length(data(1,:));
ques = ['Select a column # to use as the independent variable [1-',num2str(num_cols),']:'];
valid_input = false;
indep_col = 0;

%----------------------------------------
% Ask until valid column number is entered
%
while(~valid_input)
    
% Print data preview if titles don't exist
if(isempty(titles))
    data_preview = data([1:4],:)
else
    fprintf('\nColumn Headings.....\n');
    for col_ind = [1:num_cols]
        fprintf([num2str(col_ind),': ',titles{col_ind},'\n']);
    end%for
end%if

% Ask for input
indep_col_input = input(ques);

% Verify user input is a valid column number
if(any([indep_col_input == [1:num_cols]]))
    indep_col = indep_col_input;
    valid_input = true;
end%if
end%while
end%function


