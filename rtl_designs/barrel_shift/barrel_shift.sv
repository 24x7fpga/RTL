`timescale 1ns/1ns
`include "parameters.sv" 
module barrel_shift(/*AUTOARG*/
   // Outputs
   out_rh, out_lf,
   // Inputs
   in, rt
   ); 
  input [`WIDTH-1:0] in; 
  input [$clog2(`WIDTH)-1:0] rt;

   output [`WIDTH-1:0] 	     out_rh;
   output [`WIDTH-1:0] 	     out_lf;
   
 
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 
 
   barrel_shift_right BSR (/*AUTOINST*/
			   // Outputs
			   .out_rh		(out_rh[`WIDTH-1:0]),
			   // Inputs
			   .in			(in[`WIDTH-1:0]),
			   .rt			(rt[$clog2(`WIDTH)-1:0]));

   barrel_shift_left BSL (/*AUTOINST*/
			  // Outputs
			  .out_lf		(out_lf[`WIDTH-1:0]),
			  // Inputs
			  .in			(in[`WIDTH-1:0]),
			  .rt			(rt[$clog2(`WIDTH)-1:0]));
 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
