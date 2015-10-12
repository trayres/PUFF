%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Import data and column headings from .csv file (comma delimited form)
%%%% - Excel can save and load files in .csv format
%%%% - If first entry of first row is a letter, assume first row contains titles (column headings)
%%%% - If first entry of first row is a number, assume data starts on first row
%%%% - Intended for use with importCsvFolder.m and csv2mdf.m
%%%%
%%%% Input:
%%%% - 1 argument: Assume single argument is the filename and is located in current folder
%%%% - 2 arguments: Assume first argument is the folder name and second argument is the filename
%%%%
%%%% Outputs:
%%%% - data: data matrix
%%%% - titles: cell array of column headings. titles = '' if file does not have column headings
%%%%
%%%% Usage: 
%%%% data = importCsvColData('filename.csv');
%%%% [data,titles] = importCsvColData('foldername','filename.csv');
%%%%
%%%% Example .csv file:
%%%% ---------powerSweep.csv-----------
%%%% freq,Pin,Pout,Efficiency
%%%% 1.8,5,21,35
%%%% 1.8,6,22,34
%%%% 2.2,5,23,31
%%%% 2.2,6,24,30
%%%% ----------------------------------
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% importCsvColData.m
%%%% Last Edited: 7/27/12
%%%% Octave tested: 9/7/13
%%%% Matlab tested: 7/27/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [data,titles] = importCsvColData(varargin)

%----------------------------------------
% Save input arguments to proper variables
%	
switch(nargin)
case 1
	folder = '.';
	filename = varargin{1};
	file_loc = [filename];
case 2
	folder = varargin{1};
	filename = varargin{2};
	file_loc = [folder,'/',filename];
otherwise
	warning('function: importCsvColData');
	warning('Incorrect number of arguments');
	warning('Usage: data = importCsvColData(filename)');
	warning('Usage: [data,titles] = importCsvColData(foldername,filename)');
end%switch

%----------------------------------------
% Initialize
%
titles{1} = '';
data = [];

%----------------------------------------
% Warn the user if the target folder does not exist
%
if(isdir(folder))
    fprintf(['Directory found [ ',folder,' ]\n']);
else
    warning(['Could not find the directory [ ',folder,' ]']);
end%if

%----------------------------------------
% Warn the user if the target file does not exist
%
%[info, err, msg] = stat(file_loc);
%if(err)
%warning(['Could not load [ ',file_loc,' ]']);
%warning(msg);
%return;
%end%if
file_stat = exist(file_loc,'file');
if(file_stat == 2)
    fprintf(['File found [ ',filename,' ]\n']);
elseif(file_stat == 0)
    warning(['Could not load [ ',file_loc,' ]']);
    warning([num2str(file_stat)]);
return;
end%if

%----------------------------------------
% See if first row contains headings or numeric data
% data_start_row = 1, if no headings are present
% data_start_row = 2, if heading exist
%
[data_start_row,titles] = testForColumnHeadings(file_loc);

%----------------------------------------
% Import data
%
data = importCsvData(file_loc,data_start_row);

%----------------------------------------
% Import data
% dlmread is limited to numbers in matlab....stupid
%
%data = dlmread(file_loc,',')
%[num_rows,num_cols] = size(data);
%data = data(data_start_row:num_rows,1:num_cols);

%----------------------------------------
% remove empty rows and columns
%
%cols = find(any(data,1));
%rows = find(any(data,2));
%data = data(rows,cols);

end%function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%  END MAIN  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




function data = importCsvData(file_loc,data_start_row)

%----------------------------------------
% Initialize
%
row_counter = 1;

%----------------------------------------
% Get first line containing data
%
fid = fopen (file_loc);                         % open file
tline = fgetl(fid);
if(data_start_row == 2)
    tline = fgetl(fid);
end%if

%----------------------------------------
% Continue importing lines until eof
%
while ischar(tline)
    %find location of letters, numbers, and '-'
    data_loc = regexp(tline,'[\w\d-]');
    
    %ignore row if no letters, numbers, or '-' were found
    if(data_loc)
        %strip any trailing stuff
        tline = tline(min(data_loc):max(data_loc));
        %split row at each comma, into a cell array
        [row_cell,b] = regexp(tline,'\,+','split');
        %convert cells to numbers and store into output
        data(row_counter,:) = cellStr2num(row_cell);
        row_counter = row_counter+1;
    end%if
    tline = fgetl(fid);
end%while
fclose(fid);

end%function


function mat = cellStr2num(cell_str)

% Initialize
mat=[];
num_cells = length(cell_str);

% Convert cell array of strings to matrix of numbers
for cell_ind = [1:num_cells]
    cell_1 = cell_str(cell_ind);
    cell_mat = cell2mat(cell_1);
    cell_num = str2num(cell_mat);
    mat(1,cell_ind) = cell_num;
end%for
end%function


function [data_start_row,titles] = testForColumnHeadings(file_loc)

%----------------------------------------
% Initialize
%
alph = ['abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ()[]'];	% all letters
numbers = ['-','1','2','3','4','5','6','7','8','9'];			% all numbers and negative sign

%----------------------------------------
% Import first row of the target file
%
fid = fopen (file_loc);                         % open file
txt = fgetl (fid);                              % import first row
fclose (fid);                                   % close file

%----------------------------------------
% Filter row and split string at commas
%
%titles = strsplit(txt,',')                     % cell array (1 row)
% loc of...
% \w, (alph,number,_)
% \d, (0-9)
% -, (minus)
% (), (parentheses)
% \[\], (square brakets)
char_loc = regexp(txt,'[\w\d-()\[\]]');
txt_stripped = txt(1:max(char_loc));
titles = regexp(txt_stripped,'\,+','split');
num_titles = length(titles);                    % number of titles/columns

%----------------------------------------
% Does the first row contain titles?
% Test the first entry of the first row to see
% if it is a letter.
%
char_titles = char(titles);						% convert cell array to character matrix
alph_titles = [char_titles(1,1) == alph(:)];	% test first entry for letter match
num_titles = [char_titles(1,1) == numbers];		% test first entry for number match
first_row_isalph = any(alph_titles);			% is the first entry a letter?
first_row_isnum = any(num_titles);              % is the first entry a number?

%----------------------------------------
% Does the data start in the first or second row?
%
if(first_row_isalph && ~first_row_isnum)
	data_start_row = 2;
elseif(~first_row_isalph && first_row_isnum)
	data_start_row = 1;
	titles = '';
else
	data_start_row = 2;
	fprintf('\n****function: importCsvColData\n');
	fprintf('****first entry is not a number or letter\n')
end%if

end%function









