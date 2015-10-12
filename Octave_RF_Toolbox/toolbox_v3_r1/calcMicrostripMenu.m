%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Interactive microstrip parameter calculator, similar to linecalc
%%%% - Interface using a series of menus printed to the terminal
%%%% - Accounts for conductor thickness
%%%%
%%%% Input:	
%%%% n/a	
%%%%	
%%%% Output:
%%%% Current parameters are saved to a file after each change
%%%%	
%%%% Usage:
%%%% calcMicrostripMenu()
%%%%	
%%%% Primary reference: Andrei, p.149
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% calcMicrostripMenu.m
%%%% Last Edited: 9/22/13
%%%% Octave tested: 9/22/13
%%%% Matlab tested: Not tested and probably won't work
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function calcMicrostripMenu()

%-------------------------------------
% Inputs
%
input_folder = "linecalc_files";
input_filename = "default.txt";

%-------------------------------------
% Initialize Variables
%
num_selected = 1;

%-------------------------------------
% Create "input_folder" if it doesn't exist
%
if(~isdir(input_folder))
	printf(["***",input_folder," folder does not exist\n"]);
	printf(["***Creating folder called ",input_folder,"\n"]);
	[status, msg, msgid] = mkdir (input_folder);
end%if

%-------------------------------------
% Create default boardspec file if it doesn't exist
%
default_file_exists = file_in_path (input_folder,input_filename);	% returns [] if file doesn't exist
if(isempty(default_file_exists))
	printf("***Default boardspec file does not exist\n");
	createDefaultSpecFile([input_folder,"/",input_filename]);
end%if

%-------------------------------------
% Loop until user chooses to exit
%
while(num_selected)

%-------------------------------------
% Load boardspec parameters from file
% Path variable included in loop so the filename can be changed by a future save or load feature
%
input_data_loc = [input_folder,"/",input_filename];
input_data = load(input_data_loc)

%-------------------------------------
% Print menu and ask user for selection
%
printf("\n")
printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
printf("What would you like to do?\n");
printf("1) Calc Length & Width, given Zo & EL\n");
printf("2) Calc Zo & EL, given Length & Width\n");
printf("3) Change Inputs\n");
printf("0) exit\n");
num_selected = input("Enter a number: ");
printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");


%-------------------------------------
% Execute action depending on user input
%
switch(num_selected)
case 1
calcLandW(input_data_loc)
case 2
calcZoAndEL(input_data_loc)
case 3
changeInputs(input_data_loc)
case 0
printf("\nexiting\n");
otherwise
printf("****Invalid selection\n");
printf("****Select again\n");
end%switch


end%while

end%function





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% End Main %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function calcLandW(input_data_loc)

%-------------------------------------
% Input board specs from file
%
boardspecs = load(input_data_loc);			% load file with board specs into a structure

%-------------------------------------
% Input board specs from file
%
boardspecs.W = calcMicrostripW(boardspecs);		% Uses: Zo, t, h, Er, W, Ere
boardspecs.L = calcMicrostripL(boardspecs);		% Uses: Ere, EL, f

%-------------------------------------
% Save structure to temp file and copy to specified place
%
save "linecalc_files/temp.txt" "-struct" boardspecs "*"
[status, msg, msgid] = copyfile ("linecalc_files/temp.txt",input_data_loc,"force");

end%function




function calcZoAndEL(input_data_loc)

%-------------------------------------
% Input board specs from file
%
boardspecs = load(input_data_loc);			% load file with board specs into a structure

%-------------------------------------
% Calculate Epsilon effective, Zo, Electrical length (degrees)
%
boardspecs.Ere = calcMicrostripEre(boardspecs);		% Uses: t, h, Er, W
boardspecs.Zo = calcMicrostripZo(boardspecs);		% Uses: t, h, Er, W, Ere
boardspecs.EL = calcMicrostripEL(boardspecs);		% Uses: f, L, Ere

%-------------------------------------
% Save structure to temp file and copy to specified place
%
save "linecalc_files/temp.txt" "-struct" boardspecs "*"
[status, msg, msgid] = copyfile ("linecalc_files/temp.txt",input_data_loc,"force");

end%function




function changeInputs(input_data_loc)

%-------------------------------------
% Initialize Variables
%
num_selected = 1;

%-------------------------------------
% Loop until user enters 0
%
while(num_selected)

fflush (stdout);			% flush the input/output buffer to prevent multiple input lines from showing
boardspecs = load(input_data_loc);	% load file with board specs into a structure
var_names = fieldnames(boardspecs);	% extract all the variable names in structure
num_var = length(var_names);		% number of variables

%-------------------------------------
% Create Menu
%
printf("\n")
printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
printf("What parameter do you want to change?\n");
for vn = [1:num_var]
field_name = getfield(boardspecs,var_names{vn});
printf([num2str(vn),") ",var_names{vn},": ",num2str(field_name),"\n"]);
end%for
printf("0) Done editing\n");

%-------------------------------------
% Ask user for the variable number and new value
%
num_selected = input("Enter a number: ");
if(num_selected)
new_value = input("Enter new value: ");
end%if
printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n");

%-------------------------------------
% - Update structure with new value
% - Save new parameters to temp file
% - Copy temp file to desired file name
% - If 0 is selected, do nothing and exit
%
switch(num_selected)
case 0
printf("\nexiting\n");
otherwise
boardspecs.(var_names{num_selected}) = new_value;
save "linecalc_files/temp.txt" "-struct" boardspecs "*"
[status, msg, msgid] = copyfile ("linecalc_files/temp.txt",input_data_loc,"force");
end%switch


end%while

end%function




function createDefaultSpecFile(default_data_loc)
printf("***Creating default boardspec file\n");
boardspecs.f = 2.14e9;				% frequency
boardspecs.t = 0.0078e-3;			% conductor thickness
boardspecs.h = 0.787e-3;			% board height
boardspecs.Er = 2.2;				% epsilon relative
boardspecs.lossT = 0.0009;			% dielectric loss tangent

boardspecs.L = 16e-3;				% length
boardspecs.W = 2.14e-3;				% width
boardspecs.Zo = 50;				% characteristic impedance
boardspecs.EL = 90;				% electrical length

boardspecs.Ere = 2.4;				% epsilon effective

save "linecalc_files/temp.txt" "-struct" boardspecs "*"
[status, msg, msgid] = copyfile ("linecalc_files/temp.txt",default_data_loc,"force");

end%function








