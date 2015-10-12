####~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Import data from all .csv files in the target folder
#### - Allows many data files to be dropped in a folder and imported all at once
#### - Target folder is selected using an interactive menu
#### - Imports each file individually using importCsvColData.m
#### - Files are assumed to be in comma delimited format and contain data organized by column
#### - Files do not need to have a .csv extension as long as they are correctly formatted
#### - Refer to the m-file importCsvColData.m for file format specifics
#### - Excell can save files in .csv format
#### - Assumes target folder is in the current working directory (future modification will remove this limitation)
####
#### Input:
#### None - Future plan includes the ability to specify target folder as an input argument
####
#### Outputs:
#### folder - (string) name of selected folder containing .csv files
#### files - (cell array) list containing all file names in "folder"
#### data_all - (cell array) each cell entry is a 2D matrix containing data from one file
#### titles_all - (cell array) each cell entry is a cell array containing column headings of one file 
####
#### Usage: 
#### [folder,files,data_all,titles_all] = importCsvFolder()
####
#### Additional m-files used:
#### listDir.m, importCsvColData.m
####
#### curtis | creatingrf[@]gmail.com
#### importCsvFolder.m
#### Last Edited: 10/2/11
%%%% Octave tested:
%%%% Matlab tested: 
function [folder,files,data_all,titles_all] = importCsvFolder()

#----------------------------------------
# Initialize outputs
# This allows empty arrays to be returned if errors are encountered
#
folder = "";			# folder name(string) containing .csv files
files{1} = "";			# cell array of filenames(strings), within "folder"
data_all{1} = "";		# cell array of datasets(2D matricies), 
				# "data_all{2}" is the data from the file called "files{2}"
titles_all{1} = "";		# cell array of title lists(cell arrays), 
				# "titles_all{4}" contains the column headings from the file called "files{4}"

#----------------------------------------
# Save all folders in the current directory to a cell array
#
folder_list = listDir();

#----------------------------------------
# If no folders are found, warn user and return empty arrays
#
if(!folder_list{1})
warning("No folders found in the current directory");
warning("Called from file: importCsvFolder.m");
return;
endif

#----------------------------------------
# List all folders in the current directory and prompt user to select one
#
folder = selectFolder(folder_list);

#----------------------------------------
# Store a list of all file names in the target folder
# This will store all items in the folder, including directories, not just data files
# A check should probably be added to avoid directories or other undesired files
#
files = getFileList(folder);			# cell array
num_files = length(files);			# number of items in selected folder

#----------------------------------------
# Loop through the list of files
# Import data and column headings from each file into cell arrays
# importCsvColData.m returns empty arrays if problems are found with a file
#
for f_ind = [1:num_files]
[data_all{f_ind},titles_all{f_ind}] = importCsvColData(folder,files{f_ind});
endfor

endfunction
####-------------------------------------------------------------------------
####-------------------------END MAIN----------------------------------------
####-------------------------------------------------------------------------



function folder = selectFolder(folder_list)

num_folders = length(folder_list);
valid_user_input = [1:num_folders];	# used to check if input from user is valid

#----------------------------------------
# Display the list of folders until user makes a valid selection
#
do
	# List each folder with a number next to it [ 1: foldername1 ]
	#
	printf("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
	printf(["What folder contains the desired data files?\n"]);
	for folder_ind = [1:num_folders]
	printf([num2str(folder_ind),": ",folder_list{folder_ind},"\n"]);
	endfor

	# Prompt user to enter the number next to the desired folder
	#
	folder_num_selected = input(["Enter a number from 1 to ",num2str(num_folders),": "],"s");
	printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");

	# Convert the user input(string) to a number
	# str2num is not used because str2num("letters") returns an empty matrix, causing problems
	#
	folder_num_selected = str2double(folder_num_selected);

until(any([folder_num_selected == valid_user_input]))

#----------------------------------------
# Return the name of the selected folder
#
folder = folder_list{folder_num_selected};

endfunction





function files = getFileList(folder)

files{1} = "";					# cell array to hold list of file names
[files_in, err, msg] = readdir(folder);		# contents of selected folder

if(err) 					# warn user if an error occurs
warning(["Error getting list of files from folder [ ",folder," ]"]);
warning(err); 
else						# else, return file list
files = files_in(3:length(files_in));		# strip "." and ".." from list - cell array
endif

endfunction






