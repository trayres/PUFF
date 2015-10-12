%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function scAddCircle_test()

center_mag = 0.5;
center_angle = 50;
radius = 0.5;
color = 'g';

scCreate();
scAddCircle(center_mag,center_angle,radius,color)

fprintf('\n');
fprintf('Should see the following circle...\n');
fprintf(['center magnitude: ',num2str(center_mag),'\n']);
fprintf(['center angle: ',num2str(center_angle),'\n']);
fprintf(['radius: ',num2str(radius),'\n']);
fprintf(['color: ',color,'\n']);
fprintf('\n');

end%function
