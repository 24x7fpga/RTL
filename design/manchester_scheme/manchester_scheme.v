`timescale 1ns/1ns
module manchester_scheme (/*AUTOARG*/
   // Outputs
   d_out,
   // Inputs
   clk, d_in
   );

   input clk;
   input d_in;

   output d_out;


   /*AUTOREG*/
   /*AUTOWIRE*/

   manchester_encoder ENCOD (/*AUTOINST*/
			     // Outputs
			     .d_out		(d_out),
			     // Inputs
			     .clk		(clk),
			     .d_in		(d_in));


endmodule // manchester_scheme
// Local Variables: 
//verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
