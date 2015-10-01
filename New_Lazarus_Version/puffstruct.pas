unit PuffStruct;

{$mode objfpc}{$H+}{$M+}

interface

uses
  Classes, SysUtils;

type

  TComplex = record
   r,i : double; 	{! This was changed from a real for speed increase}
 end;

 PMemComplex = ^TMemComplex;

 TMemComplex = RECORD
   c: TComplex;
 END;

 s_param      = ^s_parameter_record;

   s_parameter_record = RECORD
   z          : PMemComplex;
   next_s     : s_param;
 end;

   line_string = string;

   compt = ^compt_record;

   compt_record = RECORD
   lngth,width,zed,zedo,init_ere,
   alpha_c,alpha_d,alpha_co,alpha_do,
   lngth0,wavelength,wavelengtho,
   zed_e0,zed_o0,zed_S_e0,zed_S_o0,
   e_eff_e0,e_eff_o0,
   u_even,u_odd,g_fac,
   con_space,spec_freq 			: double;
   xp,xmaxl,x_block,
   xorig,yp,number_of_con,used        	: integer;
   s_begin,s_file,s_ifile,f_file        : s_param;
   calc,changed,right,super,
   parsed,step,sweep_compt	 	: boolean;
   next_compt,prev_compt     		: compt;
   descript                  		: line_string;
   typ                       		: char;
 end;



  TPuffStruct = class
    public
    dev_file, net_file : TStringList;
    DemoMode, Marker_OK : Boolean;
  end;

implementation


end.

