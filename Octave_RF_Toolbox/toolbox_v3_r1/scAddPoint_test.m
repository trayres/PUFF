%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Test functionality of script
%%%%
%%%% curtis
%%%% 
%%%% Last Edited: 8/19/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function scAddPoint_test()

z1 = 2+1i;
g1_mag = 0.6;
g1_ang = 110;

scCreate();
scAddPoint(z1)
scAddPoint(g1_mag,g1_ang)

fprintf('Should see the following points...\n');
fprintf(['z1: ',num2str(z1),'\n']);
fprintf(['mag: ',num2str(g1_mag),' ang: ',num2str(g1_ang),'\n']);

end%function
