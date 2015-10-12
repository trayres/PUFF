%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%% Calculate the effective noise across a cascade of stages
%%%%
%%%% Inputs:
%%%% - gain_lineup_db - Vector w/ the Gain of each stage in db
%%%% - nf_lineup_db - Vector w/ the Noise figure of each stage in db
%%%%
%%%% Output:
%%%% NF_eff_db - effective noise figure of entire cascade in dB
%%%%
%%%% Usage:
%%%% NF_eff_db = calcCascadedNoise(gain_lineup_db,nf_lineup_db)
%%%%
%%%% Example:
%%%% gain_lineup_db = [-3,-4,15,6,-4];
%%%% nf_lineup_db = [3,4,4,9,4];
%%%% NF_eff_db = calcCascadedNoise(gain_lineup_db,nf_lineup_db)
%%%%
%%%% curtis [creatingrf at gmail.com]
%%%% calcCascadedNoise.m
%%%% Last edited: 9/7/13
%%%% Octave tested: 9/7/13
%%%% Matlab tested: 
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function NF_eff_db = calcCascadedNoise(gain_lineup_db,nf_lineup_db)

%----------------------------------------
% Inputs in db
%
%gain_lineup_db = [-3,-4,15,6,-4];
%nf_lineup_db = [3,4,4,9,4];

%----------------------------------------
% Initialize
%
num_stages = length(gain_lineup_db);

%----------------------------------------
% Convert inputs to ratio form for calculations
%
gain_lineup_ratio = 10.^(gain_lineup_db./10);
nf_lineup_ratio = 10.^(nf_lineup_db./10);

%----------------------------------------
% calculate noise added by each stage and add it to a vector
%
denom = 1;
NF_eff_per_stage(1) = nf_lineup_ratio(1);
for sn = [2:num_stages]
	numer = (nf_lineup_ratio(sn)-1);
	denom = denom*gain_lineup_ratio(sn-1);
	NF_eff_per_stage(sn) = numer/denom;
end%for

%----------------------------------------
% Calc cascaded noise by adding the NF of each stage together
%
%NF_eff_per_stage
NF_eff_ratio = sum(NF_eff_per_stage);

%----------------------------------------
% Convert NF from ratio form to dB
%
NF_eff_db = 10*log10(NF_eff_ratio);

end%function





