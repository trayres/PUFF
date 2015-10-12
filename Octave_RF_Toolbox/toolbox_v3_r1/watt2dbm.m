%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Convert watts to dbm
%%%%
%%%% Input:
%%%% watts - numerical value
%%%% 	
%%%% Output:
%%%% dbm - numerical value
%%%%
%%%% Usage:
%%%% dbm = watt2dbm(watt)
%%%%
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% watt2dbm.m
%%%% Last Edited: 6/14/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/14/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function dbm = watt2dbm(watt)
	dbm = 10*log10(watt/(1e-3));
end%function

