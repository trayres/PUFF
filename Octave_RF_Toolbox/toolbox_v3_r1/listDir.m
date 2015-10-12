%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Create a list of directories in a target folder
%%%% - If no arguments are passed, list all folders in the current working directory
%%%% - '!' changed to '~' for matlab compatability
%%%%
%%%% Inputs:
%%%% target_dir - location of target directory to search for subfolders
%%%%
%%%% Outputs
%%%% dir_list - cell array containing names of subfolders inside of target directory
%%%%
%%%% Usage:
%%%% [dir_list] = listDir;
%%%% target_dir = './foldername';
%%%% [dir_list] = listDir(target_dir);
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% listDir.m
%%%% Last Edited: 6/14/12
%%%% Octave tested: 
%%%% Matlab tested: readdir() not a valid matlab function...fail
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function dir_list = listDir(varargin)

%--------------------------------------
% Initialize
%
dir_list{1} = 0;			% stores directory names
dir_ind = 1;				% index of directory names
working_dir = './';   			% current directory/folder

%--------------------------------------
% Set search_folder to the input argument or working directory
%
switch(nargin)

% If the first argument is an existing folder, 
% set target folder equal to the first argument
case 1					 
	arg_in = varargin{1};		% requested search folder

	if(isdir(arg_in))		% if the 1st argument is an existing folder
	search_folder = arg_in;		
	else				% if the 1st argument is NOT an existing folder
	warning(['The folder [ ',arg_in,' ] could not be located']);
	warning('Setting target folder to the current directory');
	search_folder = working_dir;
    end%if

% If no input arguments exist, search the current working directory
case 0
	search_folder = working_dir;

% If more than 1 argument is passed, warn the user and print the proper usage
otherwise
	warning('Invalid number of arguments: listDir.m');
	warning('Usage');
	warning('[dir_list] = listDir();');
	warning('[dir_list] = listDir(parent_directory);');
end%switch

%--------------------------------------
% Create a list of everything in search folder
%
[items_in, err, msg] = readdir(search_folder);	% create list
num_items = length(items_in);			% number of items in folder

%--------------------------------------
% Test each item in folder to see if it
% is a directory.  If it is a directory,
% save it in a different cell array.
%
for ind = [1:num_items]
	name = items_in{ind};			% file/directory name
	item_loc = [search_folder,'/',name];	

	if(isdir(item_loc))			% if it is a directory
	if(name ~= '.')				% and not '.' or '..'
	dir_list{dir_ind} = name;		% save directory name to cell array
	dir_ind = dir_ind+1;			% counter
    end%if					%
    end%if					%
end%for

end%function






