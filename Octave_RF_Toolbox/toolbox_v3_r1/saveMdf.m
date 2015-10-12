%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Save data list to file in .mdf format
%%%% - .mdf files can be read into ADS or octave
%%%% - can create multiple sections based on an indep var
%%%% - It puts all data in a single section if indep_col=''
%%%%
%%%% Inputs
%%%% - output_loc(string) = [foldername,'/',filename,'.mdf']
%%%% - data(matrix): numerical matrix
%%%% - var_names(cell array): variable names each column of the data matrix
%%%% - comments(cell array): any comments to be added to top of mdf 
%%%% - sweep_name(string): name of overall sweep. will show in ADS
%%%% - indep_col(number): which column of the data matrix is the
%%%% independent variable?
%%%%
%%%% Result
%%%% - mdf file created at 'output_loc' of the form.....
%%%% ------------------------------
%%%% BEGIN DSCRDATA
%%%% % INDEX	R	I
%%%% 1		25	-19
%%%% 2		13	-4
%%%% END
%%%%--------------or---------------
%%%% ! title
%%%% VAR VGS(real)=-1.5
%%%% BEGIN Sweep1.DC1.DC
%%%% % VDS(real)	IDSa.i(real)   
%%%% 0.0	7.5e-6
%%%% 0.1	8.1e-6
%%%% END
%%%%
%%%% VAR VGS(real)=-1.5
%%%% BEGIN Sweep1.DC1.DC
%%%% % VDS(real)	IDSa.i(real)   
%%%% 0.0	7.5e-6
%%%% 0.1	8.1e-6
%%%% END
%%%%------------------------------
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% saveMdf.m
%%%% Last Edited: 8/1/12
%%%% Octave tested: 9/7/13
%%%% Matlab tested: 8/1/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function saveMdf(output_loc,data,var_names,comments,sweep_name,indep_col)

%-----------------------------------------
% init
%
num_cols = length(data(1,:));
col_list = [1:num_cols];

%----------------------------------------
% Should data be split up by an independent variable?
%
if(indep_col)
    use_indep_var = true;
else
    use_indep_var = false;
end%if

%----------------------------------------
% Find data columns
%
if(use_indep_var)
data_cols = find([col_list ~= indep_col]);
else
data_cols = col_list;
end%if

%----------------------------------------
% Find variable names
%
if(isempty(var_names))
    fprintf('No column headings - Using default variable names\n');
    for var_ind = [1:num_cols]
        var_names{var_ind} = ['var',num2str(var_ind)];
    end%for
end%if

%----------------------------------------
% Create new mdf file
%
%fprintf('\n...Creating MDF file\n');
createMdfFile(output_loc)

%----------------------------------------
% Add comments
%
%fprintf('\n...Adding comments to MDF file\n');
addMdfComments(output_loc,comments)



%----------------------------------------
% If using an independent variable, create a section in the
% mdf file for each independent variable value.
% If not using an indep variable, save all data to one section
% - saved columns are specified by the variable data_cols
% - could use it to make columns selectable in the future
%
%fprintf('\n...Adding data to MDF file\n');
switch use_indep_var
case true
    % create vector of each indep variable value
    indep_var_unique = unique(data(:,indep_col));
    
    % create a section for each indep variable value
    for indep_var_ind = [1:length(indep_var_unique)]
        indep_var = indep_var_unique(indep_var_ind);
        
        % find rows matching the current indep variable value
        row_targets = find([data(:,indep_col) == indep_var]);
        % grab all data related to the current indep variable value
        data_temp = data(row_targets,data_cols);
        % save the indep variable name and value to the file
        header0 = ['VAR ',var_names{indep_col},'=',num2str(indep_var)];
        dlmwrite(output_loc,header0,'delimiter','','-append','newline','pc');
        % save all data related to the current indep value to the file
        addSection(output_loc,data_temp,sweep_name,var_names(data_cols))
    end%for
case false
        data_temp = data(:,data_cols);
        addSection(output_loc,data_temp,sweep_name,var_names(data_cols));
end%switch
end%function





function addSection(output_loc,data,sweep_name,var_names)

%-----------------------------------------
% mdf file section
%
% BEGIN Sweep1.DC1.DC
% % VDS(real)	IDSa.i(real)   
% 0.0	7.5e-6
% 0.1	8.1e-6
% END

%-----------------------------------------
% header and trailer text (in sections with independent variable)
%
header1 = ['BEGIN ',sweep_name];
header2 = '%';
for var_ind = [1:length(var_names)]
    header2 = [header2,' ',var_names{var_ind}];
end%for
trailer1 = 'END';

%-----------------------------------------
% create file (in sections with independent variable)
%
dlmwrite(output_loc,header1,'delimiter','','-append','newline','pc');	% define variable
dlmwrite(output_loc,header2,'delimiter','','-append','newline','pc');	% define column headings
dlmwrite(output_loc,data,'delimiter','\t','-append','newline','pc');	% save data
dlmwrite(output_loc,trailer1,'delimiter','','-append','newline','pc');	% declare end of variable
dlmwrite(output_loc,' ','delimiter','','-append','newline','pc');		% declare end of variable

end%function

function addIndepSection(output_loc,data,indep_var)

%-----------------------------------------
% mdf file layout (in sections with independent variable)
%
% ! title
% VAR VGS(real)=-1.5
% BEGIN Sweep1.DC1.DC
% % VDS(real)	IDSa.i(real)   
% 0.0	7.5e-6
% 0.1	8.1e-6
% END
%
% VAR VGS(real)=-1.5
% BEGIN Sweep1.DC1.DC
% % VDS(real)	IDSa.i(real)   
% 0.0	7.5e-6
% 0.1	8.1e-6
% END

%-----------------------------------------
% header and trailer text (in sections with independent variable)
%
header0 = ['VAR VGS(real)=',num2str(indep_var)];
header1 = 'BEGIN Sweep1.DC1.DC';
header2 = '% VDS(real) IDSa.i(real)';
trailer1 = 'END';

%-----------------------------------------
% create file (in sections with independent variable)
%
dlmwrite(output_loc,header0,'delimiter','','-append','newline','pc');	% define variable
dlmwrite(output_loc,header1,'delimiter','','-append','newline','pc');	% define variable
dlmwrite(output_loc,header2,'delimiter','','-append','newline','pc');	% define column headings
dlmwrite(output_loc,data,'delimiter','\t','-append','newline','pc');	% save data
dlmwrite(output_loc,trailer1,'delimiter','','-append','newline','pc');	% declare end of variable
dlmwrite(output_loc,' ','delimiter','','-append','newline','pc');		% declare end of variable

end%function

function addBasicSection()

%-----------------------------------------
% mdf file layout (basic R/I output)
%
% BEGIN DSCRDATA
% % INDEX	R	I
% 1		25	-19
% 2		13	-4
% END

%-----------------------------------------
% header and trailer text (basic R/I output)
%
%header1 = 'BEGIN DSCRDATA';
%header2 = '% INDEX R I';
%trailer1 = 'END';

%-----------------------------------------
% create file (basic R/I output)
%
%dlmwrite(output_loc,header1,'','newline','pc');				% define variable
%dlmwrite(output_loc,header2,'','append','on','newline','pc');		% define column headings
%dlmwrite(output_loc,data_out,'\t','append','on','newline','pc');	% save data
%dlmwrite(output_loc,trailer1,'','append','on','newline','pc');		% declare end of variable
end%function

function createMdfFile(output_loc)
dlmwrite(output_loc,['! ~~~~~~~~~~~~~~~~~~~~'],'delimiter','','newline','pc');
end%function

function addMdfComments(output_loc,comments)
for comment_ind = [1:length(comments)]
dlmwrite(output_loc,['! ',comments{comment_ind}],'delimiter','','-append','newline','pc');
end%for
end%function



