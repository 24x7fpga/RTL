`timescale 1ns/1ns
`include "parameters.sv" 
module barrel_shift(/*AUTOARG*/
   // Outputs
   out,
   // Inputs
   in, rot
   ); 
  input [`WIDTH-1:0] in; 
  input [$clog2(`WIDTH)-1:0] rot;

   output [`WIDTH-1:0] 	     out;
   
 
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 
 
barrel_shift_right BSR (/*AUTOINST*/
			// Outputs
			.out		(out[`WIDTH-1:0]),
			// Inputs
			.in		(in[`WIDTH-1:0]),
			.rot		(rot[$clog2(`WIDTH)-1:0])); 
 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
