%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert dB to ratio
%%%%
%%%% Input:
%%%% dB - numerical value
%%%% 	
%%%% Output:
%%%% ratio - numerical value
%%%%
%%%% Usage:
%%%% ratio = db2r(db)
%%%%
%%%% curtis [creatingrf at gmail.com]
%%%% db2r.m
%%%% Last Edited: 3/1/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function ratio = db2r(db)
	ratio = 10^(db/10);
end%function




