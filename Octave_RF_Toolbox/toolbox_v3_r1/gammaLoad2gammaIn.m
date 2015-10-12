%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Transform load reflection coef. to input reflection coef.
%%%% of specified s-parameters
%%%% -- Basically embedding s-parameters in front of a load
%%%% -- Can be used to see how an amplifier load effects the input refl coef
%%%% -- Stability can be checked by load pulling and monitoring the input
%%%%
%%%% Output:
%%%% gamma_input_mag - input reflection coefficient magnitude
%%%% gamma_input_ang - input reflection coefficient angle (degrees)
%%%% 
%%%% Input:
%%%% s = [s11rect, s12rect ; s21rect, s22rect ]
%%%% gamma_load_mag - load reflection coefficient magnitude
%%%% gamma_load_ang - load reflection coefficient angle (degrees)
%%%%	
%%%% Usage: 
%%%% [gamma_in_mag,gamma_in_ang] = gammaLoad2gammaIn(s,gamma_load_mag,gamma_load_ang)
%%%% 
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% gammaLoad2gammaIn.m
%%%% Last Edited: 6/15/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [gamma_in_mag,gamma_in_ang] = gammaLoad2gammaIn(s,gamma_load_mag,gamma_load_ang)

%---------------------------------------------------------
% Split matrix into variables
%
s11 = s(1,1);
s21 = s(2,1);
s12 = s(1,2);
s22 = s(2,2);

%---------------------------------------------------------
% Convert load reflection coef. from polar to rectangular form
%
gamma_load_rect = ptor(gamma_load_mag,gamma_load_ang);

%---------------------------------------------------------
% Calc input reflection coef.
%
gamma_in_rect = s11+((s12*s21*gamma_load_rect)/(1-(s22*gamma_load_rect)));

%---------------------------------------------------------
% Convert input reflection coef. from rectangular to polar form
%
[gamma_in_mag,gamma_in_ang] = rtop(gamma_in_rect);


end%function







