%%%%%%%%%%%%%%%%%%% START example2.m %%%%%%%%%%%%%%%%%%%
% Calculate the reflection coeff. of a given load impedance.
% Convert the reflection coeff. from polar to rectangular, and back to polar
% Convert reflection coeff. back to its original load impedance
% Demonstrates how to use the tools: ztog, ptor, rtop, and gtoz
%
% curtis | creatingrf[@]gmail.com
% Last Edited: 6/15/12
% Octave tested: 9/7/13
% Matlab tested: 6/15/12
function example2()

% Inputs
% Characteristic impedance, Load impedance, and normalized load impedance
Zo = 50
ZL = 10-20i
zL = ZL/Zo

% Calculate reflection coeff.
[refl_mag,refl_ang] = ztog(ZL,Zo)

% Convert reflection coeff. to rectangular coordinates
refl_rect = ptor(refl_mag,refl_ang)

% Convert reflection coeff. back to polar form
[refl_mag2,refl_ang2] = rtop(refl_rect)

% Convert reflection coeff. back to impedance
[zL2,ZL2] = gtoz(refl_mag2,refl_ang2,Zo)

end%function
%%%%%%%%%%%%%%%%%%% END example2.m %%%%%%%%%%%%%%%%%%%
