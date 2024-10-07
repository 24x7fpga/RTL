`timescale 1ns/1ns
module manchester_scheme (/*AUTOARG*/
   // Outputs
   d_encod, d_decod,
   // Inputs
   clk, rst, d_in
   );

   input clk;
   input rst;
   
   input d_in;

   output d_encod;
   output d_decod;
   

   /*AUTOREG*/
   /*AUTOWIRE*/

   manchester_encoder ENCOD (/*AUTOINST*/
			     // Outputs
			     .d_encod		(d_encod),
			     // Inputs
			     .clk		(clk),
			     .d_in		(d_in));

   manchester_decoder DECOD (/*AUTOINST*/
			     // Outputs
			     .d_decod		(d_decod),
			     // Inputs
			     .clk		(clk),
			     .rst		(rst),
			     .d_encod		(d_encod));
 
			     

endmodule // manchester_scheme
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
