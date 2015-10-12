%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert a ratio to db
%%%%
%%%% Input:
%%%% ratio - numerical value
%%%% 	
%%%% Output:
%%%% db - numerical value
%%%%
%%%% Usage:
%%%% db = r2db(ratio)
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% r2db.m
%%%% Last Edited: 6/14/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function db = r2db(ratio)
	db = 10*log10(ratio);
end%function




