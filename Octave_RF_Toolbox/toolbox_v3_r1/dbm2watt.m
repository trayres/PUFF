%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert dBm to watts
%%%%
%%%% Input:
%%%% dBm - numerical value
%%%% 	
%%%% Output:
%%%% watts - numerical value
%%%%
%%%% Usage:
%%%% watts = dbm2watt(dbm)
%%%%
%%%% curtis [creatingrf at gmail.com]
%%%% dbm2watt.m
%%%% Last Edited: 8/15/11
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function watts = dbm2watt(dbm)
	watts = (1e-3)*(10^(dbm/10));
end%function




