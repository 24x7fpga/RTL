`timescale 1ns/1ns 
module ring_cntr #(parameter N = 4)(/*AUTOARG*/
   // Outputs
   sr_cntr, tr_cntr,
   // Inputs
   clk, rst
   );
   // outputs
   output [N-1:0] sr_cntr;
   output [N-1:0] tr_cntr;
   // inputs
   input	  clk;
   input	  rst;
   
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 
 
simp_ring_cntr #(/*AUTOINSTPARAM*/
		 // Parameters
		 .N			(N)) SIMPLE (/*AUTOINST*/
						     // Outputs
						     .sr_cntr		(sr_cntr[N-1:0]),
						     // Inputs
						     .clk		(clk),
						     .rst		(rst)); 
twist_ring_cntr #(/*AUTOINSTPARAM*/
		  // Parameters
		  .N			(N)) TWISTED (/*AUTOINST*/
						      // Outputs
						      .tr_cntr		(tr_cntr[N-1:0]),
						      // Inputs
						      .clk		(clk),
						      .rst		(rst)); 
 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
