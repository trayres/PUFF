%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%%%
%%%% Returns various properties of certain materials
%%%% - Originally intended to return the conductivity of copper or silver
%%%% - Has been expanded to include other materials and properties
%%%% - Material data at bottom of script
%%%% - Median value assumed when a property has a range of posssible values
%%%%
%%%% Input:
%%%% Material: 'Silver','Copper','Gold','Nickel','Air'...
%%%% Property:
%%%% 'rho' - resistivity [ohm*m]
%%%% 'cond' - Conductivity [S/m]
%%%% 't' - Temp Coeff. [K^-1]
%%%%
%%%% Usage:
%%%% output = materialProperties('Copper','cond')
%%%% output = materialProperties('Silver','rho')
%%%%
%%%% curtis | creatingrf[@]gmail.com
%%%% materialProperties.m
%%%% Last Edited: 6/15/12
%%%% Octave tested: 9/1/13
%%%% Matlab tested: 6/15/12
%%%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function output = materialProperties(material,property)

%----------------------------------
% Initialize
%
output = 0;
col = 2;

%----------------------------------
% Select column of requested property
%
switch (property)
case 'rho'
	col = 1;
case 'cond'
	col = 2;
case 't'
	col = 3;
otherwise
	warning('invalid property option');
	warning('Options: rho, cond, t');
end%switch

%----------------------------------
% Create material-value matrix
%
[mat] = defineMaterials();

%----------------------------------
% Look for requested material
%
field_exists = isfield(mat,material);
mat_names = fieldnames(mat);
if(field_exists)
	mat_properties = getfield(mat,material);
	output = mat_properties(col);
else
	fprintf('function: materialProperties.m\n');
	fprintf('could not find requested material\n');
	fprintf('data available for the following materials...\n');
	mat_names
end%if


end%function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Material definitions
%%%%
function [mat] = defineMaterials()

%%%%%%%%%%%%%%%%%%%%%%%%  Rho[ohm*m]	Cond[S/m]	t_coef[K^-1]
mat.Silver 		= [ 1.59e-8 	6.30e7 		0.0038 ];
mat.Copper		= [ 1.68e-8	5.96e7		0.0039	];
mat.AnnealedCopper	= [ 1.72e-8	5.80e7		0	];
mat.Gold		= [ 2.44e-8	4.52e7		0.0034	];
mat.Aluminium		= [ 2.82e-8	3.5e7		0.0039	];
mat.Calcium		= [ 3.36e-8	2.98e7		0.0041	];
mat.Tungsten		= [ 5.60e-8	1.79e7		0.0045	];
mat.Zinc		= [ 5.90e-8	1.69e7		0.0037	];
mat.Nickel		= [ 6.99e-8	1.43e7		0.006	];
mat.Lithium		= [ 9.28e-8	1.08e7		0.006	];
mat.Iron		= [ 1.0e-7	1.00e7		0.005	];
mat.Platinum		= [ 1.06e-7	9.43e6		0.00392	];
mat.Tin			= [ 1.09e-7	9.17e6		0.0045	];
mat.Lead		= [ 2.2e-7	4.55e6		0.0039	];
mat.Titanium		= [ 4.20e-7	2.38e6		0	];
mat.Manganin		= [ 4.82e-7	2.07e6		0.000002];
mat.Constantan		= [ 4.9e-7	2.04e6		0.000008];
mat.Mercury		= [ 9.8e-7	1.02e6		0.0009	];
mat.Nichrome		= [ 1.10e-6	9.09e5		0.0004	];
mat.Germanium		= [ 4.6e-1	2.17		-0.048	];
mat.Seawater		= [ 2e-1	4.8		0	];
mat.DrinkingWater	= [ 2e2		5e-3		0	];
mat.DeionizedWater	= [ 1.8e5	5.5e-6		0	];
mat.Silicon		= [ 6.40e2	1.56e-3		-0.075	];
mat.Glass		= [ 10e12	1e-13		0	];
mat.HardRubber		= [ 1e13	1e-14		0	];
mat.Sulfur		= [ 1e15	10-16		0	];
mat.Air			= [ 2.3e16	5.5e-15		0	];
mat.Paraffin		= [ 1e17	1e-18		0	];
mat.Quartz		= [ 7.5e17	1.3e-18		0	];
mat.PET			= [ 1e20	1e-21		0	];
mat.Teflon		= [ 1e23	1e-24		0	];


end%function
