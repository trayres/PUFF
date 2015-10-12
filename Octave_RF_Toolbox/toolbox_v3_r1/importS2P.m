%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Import sNp file
%%%% - If a second dataset is found, assumes frequency decreases between datasets
%%%% - The return values of sNp_format are useful to find the units of frequency, and
%%%% - to know if the parameters are in real/imaginary(RI) form or mag/angle(MA) form
%%%% - '!' changed to '~' for matlab compatability
%%%% - Currently only works with s2p files
%%%%
%%%% Input:
%%%% folder - name of folder where .sNp is
%%%% filename - name of sNp file (including extension)
%%%%
%%%% Output:
%%%% params - [matrix] - data/parameters in primary dataset of .sNp file
%%%% dataset2 - [matrix] - data in second dataset, if it exists (noise info)
%%%% sNp_format - [cell array of strings] - Describes the type of data
%%%% comments - [cell array of strings] - Any line that starts with '!'
%%%%
%%%% Example sNp_format contents.....
%%%% sNp_format.freq_unit = GHZ
%%%% sNp_format.param_type = Y
%%%% sNp_format.MA_RI = MA
%%%% sNp_format.R = R
%%%% sNp_format.Zo = 50
%%%%
%%%% Usage: 
%%%% params = importS2P(filename)
%%%% [params,dataset2] = importS2P(filename)
%%%% [params,dataset2,sNp_format_info] = importS2P(folder,filename)
%%%% [params,dataset2,sNp_format_info,comments] = importS2P(folder,filename)
%%%%
%%%% Example:
%%%% folder = 'sNp_file_folder'
%%%% filename = 'filename.s2p'
%%%% [params,dataset2,sNp_format_info,comments] = importS2P(folder,filename)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% importS2P.m
%%%% Last edited: 6/15/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: does not work as of 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [params,dataset2,sNp_format_info,comments] = importS2P(varargin)

%------------------------------------------
% Options
%
%verbose_output = 'true';

%------------------------------------------
% Initialize outputs
%
params = 0;
dataset2 = 0;
comments{1} = [];

%----------------------------------------
% save input arguments 
%
switch (nargin)
case 1						% target s2p file is located in the same folder
	filename = varargin{1};
	file_loc = [filename];			% location of s2p file
case 2						% target s2p file is located in a subfolder
	folder = varargin{1};
	filename = varargin{2};
	file_loc = [folder,'/',filename];	% location of s2p file
otherwise
	warning('incorrect number of arguments to function importS2P');
	warning('Usage: [sparams] = importS2P(filename)');
	warning('Usage: [sparams,additional_dataset] = importS2P(folder,filename)');
	return;
end%switch

%----------------------------------------
% Quit if file check is false 
%
if(~checkFileLocation(file_loc))
	warning('error locating the file');
	return;
end%if

%----------------------------------------
% Import entire file - ignore empty lines
%
%fprintf('..Importing File\n');
file_in = importEntireFile(file_loc);

%----------------------------------------
% Split file into comments(!), formatting(%), and data
%
%fprintf('..Filtering Data\n');
[comments,format_info,data_all] = separateLineTypes(file_in);

%----------------------------------------
% Split format_info into structure of properties 
%
%fprintf('..Creating structure of format info\n');
sNp_format_info = createFormatStruct(format_info);

%----------------------------------------
% Split data into primary and secondary datasets
% ....Some s2p files include a second dataset (Ex: noise data) 
%
%fprintf('..Splitting primary and secondary datasets\n');
[params,dataset2] = splitDatasets(data_all);

end%function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%-END MAIN-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function sNp_format = createFormatStruct(cell_in)

%----------------------------------------
% Create cell array containing all the formatting properties 
%
line_in = toupper(cell_in{1});			% string, all uppercase
line_sep = strsplit(line_in,' ');		% cell array of strings
empty_cells = cellfun('isempty', line_sep);	% ind loc of empty cells
numeric_cell_loc = find([empty_cells == 0]);	% loc of cells with data
data_in = line_sep(numeric_cell_loc);		% remove empty spots in array
data_in(1) = [];				% remove leading '#'

%----------------------------------------
% save each property to a common structure 
%
sNp_format.freq_unit = data_in{1};		% Ex: HZ,KHZ,MHZ,GHZ
sNp_format.param_type = data_in{2};		% Ex: S,Y,Z
sNp_format.MA_RI = data_in{3};			% Ex: MA,RI
sNp_format.R = data_in{4};			% Ex: R
sNp_format.Zo = data_in{5};			% Ex: 50

end%function


function file_exists = checkFileLocation(file_loc)

%----------------------------------------
% Save file stats into the structure s, and variables err & msg
%
[s, err, msg] = lstat(file_loc);

%----------------------------------------
% Check file was found successfully 
%
if(~err)
	file_exists = true;
else
	file_exists = false;
	warning(msg);
end%if
end%function


function [dataset1,dataset2] = splitDatasets(data_all)

%----------------------------------------
% Initialize  
%
dataset1 = [];
dataset2 = [];
ind2 = 1;				% line counter for additional dataset
indf = 1;  				% frequency counter
additional_data_exists = false;  	% set to true when freq decreases
data_all;				% input is a cell array of strings


%----------------------------------------
% Loop across each data line (cell array entries 
%
num_lines = length(data_all);
for ind = [1:num_lines]
new_freq_line = false;  		% set to true when line contains 9elements=1freq+8data

%----------------------------------------
% Grab one string, representing one line of data
%
%fprintf(['~~~##~~~~Line number [',num2str(ind),']\n']);
line_in = data_all{ind};			% string

%----------------------------------------
% Convert each number in the string to a cell array entry 
%
line_sep = strsplit(line_in,' ');		% cell array of strings
empty_cells = cellfun('isempty', line_sep);	% ind loc of empty cells
numeric_cell_loc = find([empty_cells == 0]);	% loc of cells with data
data_in = line_sep(numeric_cell_loc);		% remove empty spots in array
num_data_points = length(data_in);		% number of numbers in the data row

%----------------------------------------
% check for correct number of values in the row
%
if(num_data_points ~= 8)
new_freq_line = true;
end%if

%----------------------------------------
% Convert the cell array of strings into a vector of numbers 
%
row = [];					% clear vector so it can change sizes
for col_num = [1:num_data_points]		% for each entry of the cell array
row(1,col_num) = str2num(data_in{col_num});	% convert string to a number save to a vector
end%for

if(new_freq_line)
freq = row(1,1);

%----------------------------------------
% initialize last_freq to first row value, so it can be compared to later 
%
if(ind == 1)
last_freq = freq;
end%if

%----------------------------------------
% check if a new dataset has started, by seeing if the frequency has decreased 
%
if(ind > 1)
%	printf('ind is greater than one...\n');
	freq_diff = freq-last_freq;
	last_freq = freq;
	
	if(freq_diff < 0)
%	printf('Frequency decreased.....\n');
%	printf('Additional_data_exists.....\n');
	additional_data_exists = true;
	else
%	printf('Freqeuncy is increasing....\n');
	end%if
end%if  % if(ind > 1)
end%if  % if(new_freq_line)

%----------------------------------------
% Append row of data to the correct dataset 
%
if(~additional_data_exists)
%	printf('additional data does not exist....\n');

	if(new_freq_line)
	dataset1(indf,1:num_data_points) = row;
	indf = indf+1;
	col_start = length(row)+1;
	else
	dataset1(indf,:);
	row;
%	col_start = length(dataset1(indf,:))+1;
	col_end = col_start+length(row)-1;
	dataset1(indf,col_start:col_end) = [row];
	col_start = col_start+length(row);
    end%if

elseif(additional_data_exists)
%	printf('Additional_data_exists.....\n');
	dataset2(ind2,:) = row;
	ind2 = ind2+1;
end%if

end%for	% restart loop and grab the next line

%dataset1
%dataset2
end%function


function [comments,format_info,data] = separateLineTypes(file_in)

%----------------------------------------
% Initialize output cell arrays and line counters 
%
comments{1} = [];				% output cell arrays
format_info{1} = [];				%
data{1} = [];					%
comments_ind = 1;				% line counters
format_ind = 1;					%
data_ind = 1;					%

%----------------------------------------
% Loop across every line/entry in file_in 
%
num_lines = length(file_in);
for ind = [1:num_lines]

line_in = file_in{ind};				% current line
first_char = line_in(1);			% first character of the line

%----------------------------------------
% If the line starts with a '!' it's a comment
% If the line starts with a '#' it contains formatting data
% Otherwise, assume the line contains data 
%
switch(first_char)
case '!'
	comments{comments_ind} = line_in;
	comments_ind = comments_ind+1;
case '#'
	format_info{format_ind} = line_in;
	format_ind = format_ind+1;
otherwise
	data{data_ind} = line_in;
	data_ind = data_ind+1;
end%switch
end%for
end%function


function [file_in] = importEntireFile(file_loc)

line_num = 1;					% line counter
line_in = '';
fid = fopen(file_loc, 'rt', 'ieee-le');		% open file for read (text)
%first_char = fgets(fid,1)			% read one character

do						% loop until end of file
	if(~isempty(line_in))			% if the line contains something
	file_in{line_num} = line_in;		% save line to cell array
	line_num = line_num+1;			% incriment line counter
    end%if
	[line_in,line_length] = fgetl(fid);	% import one line
until(line_in == -1)

fclose(fid);					% close file handle

end%function



