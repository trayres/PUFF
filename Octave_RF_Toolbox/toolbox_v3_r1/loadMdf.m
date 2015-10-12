%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Load data from .mdf file 
%%%% - ADS and Octave can load arrays of data in .mdf format
%%%% - Can only load Mdf files with a single dataset (need to fix)
%%%%
%%%% Input:
%%%% - 1 argument: Assume single argument is the filename and is located in current folder
%%%% - 2 arguments: Assume first argument is the folder name and second argument is the filename
%%%%
%%%% Outputs:
%%%% - data: data matrix
%%%%
%%%% BEGIN DSCRDATA
%%%% % INDEX	R	I
%%%% 1		25	-19
%%%% 2		13	-4
%%%% END
%%%%
%%%% Usage: 
%%%% [data] = loadMdf('filename.mdf');
%%%% [data,column_headings] = loadMdf('foldername','filename.mdf');
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% loadMdf.m
%%%% Last Edited: 10/6/13
%%%% Octave tested: 10/6/13
%%%% Matlab tested:
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [data,col_headings] = loadMdf(varargin)

%----------------------------------------
% Inputs
%	
switch(nargin)
case 1								% if only the filename is provided
	filename = varargin{1};
	file_loc = [filename];
case 2								% if the filename and subfolder are provided
	folder = varargin{1};
	filename = varargin{2};
	file_loc = [folder,'/',filename];
otherwise							% if anything but 1 or 2 arguments are supplied
	warning('function: loadMdf');				% print a warning
	warning('Incorrect number of arguments');
	warning('Usage data = loadMdf(filename)');
	warning('Usage data = loadMdf(foldername,filename)');
end%switch

%----------------------------------------
% Initialize
%
data_row_start = 3;
row_counter = 1;
col_headings = [];

%----------------------------------------
% Import column titles (from first file)
% Assume all files have identical column headings
%
fid = fopen (file_loc);					% open file
txt = fgetl(fid);					% import first row

while(txt ~= -1);					% until eof

row_data = strsplit(txt,' \t');				% cell array (1 row) - split by a space or tab

if(strcmp('BEGIN',row_data{1}))				% start of input
	name = row_data{2};				% input variable name
elseif(strcmp('%',row_data{1}))				% if a row of column headings
	col1_name = row_data{2};			% heading of first column
	col2_name = row_data{3};			% heading of second column
	col3_name = row_data{4};			% heading of third column
	col_headings = row_data;
	col_headings(1) = [];				% strip '%' from list of headings
	num_data_cols = length(row_data)-1;		% number of columns with headings
	data_start_row = row_counter+1;			% incriment row counter
elseif(strcmp('END',row_data{1}))			% end of input variable
	end_found = true;				% not used
	data_end_row = row_counter-1;			% incriment row counter
end%if

txt = fgetl(fid);					% import next row
row_counter = row_counter+1;				% incriment row counter
end%while
fclose (fid);						% close file

%----------------------------------------
% Import data
%
data = dlmread(file_loc,' \t');						% Import spaced or tab data from file
[num_rows,num_cols_in] = size(data);					% find number of rows and columns
data = data(data_start_row:data_end_row,1:num_data_cols);		% strip titles if they exist

end%function









