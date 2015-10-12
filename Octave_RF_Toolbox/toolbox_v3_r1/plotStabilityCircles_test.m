%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function plotStabilityCircles_test()

%---------------------------------------------------------
% Plot stability circles of all frequencies in an s2p file
%
folder = './';
filename = 'example3data.s2p';
plotStabilityCircles(folder,filename)

% Print explaination and hold
fprintf('\n');
fprintf(['............................................................\n']);
fprintf(['...These are the stability circles of all frequencies \n']);
fprintf(['...in the file [ ',filename,' ]\n']);
fprintf(['...There should be 9 red on the left and 9 blue near the top\n']);
user_input = input('Press Enter to continue');
fprintf(['###################--END--######################\n\n']);

%---------------------------------------------------------
% Plot stability circles of specific s-parameters
%
s = [ptor(0.69,-78),ptor(0.033,41.4);ptor(5.67,123),ptor(0.84,-25)];
plotStabilityCircles(s)

% Print explaination and hold
fprintf('\n');
fprintf(['............................................................\n']);
fprintf(['...These are the stability circles of specific s-parameters \n']);
fprintf(['...There should be 1 red on the top-left and 1 blue near the top-right\n']);
user_input = input('Press Enter to continue');
fprintf(['###################--END--######################\n\n']);


%---------------------------------------------------------
% Plot stability circles from an s2p file 
% for a specified frequency range
%
folder = './';
filename = 'example3data.s2p';
f_min = 3.0;
f_max = 3.1;
plotStabilityCircles(folder,filename,f_min,f_max)

% Print explaination and hold
fprintf('\n');
fprintf(['............................................................\n']);
fprintf(['...These are the stability circles of s-parameters\n']);
fprintf(['...in the file [ ',filename,' ]\n']);
fprintf(['...for frequencies from [ ',num2str(f_min),' ] to [ ',num2str(f_max),' ]\n']);
fprintf(['...There should be 3 red on the left and 3 blue near the top\n']);
fprintf(['###################--END--######################\n\n']);

end%function
