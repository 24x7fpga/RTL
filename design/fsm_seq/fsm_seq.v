`timescale 1ns/1ns 
module fsm_seq(/*AUTOARG*/
   // Outputs
   dout_mealy, dout_moore,
   // Inputs
   clk, rst, din
   );
   input clk;
   input rst;
   input din;
   output dout_mealy;
   output dout_moore;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   mealy_seq fsm_mealy (/*AUTOINST*/
			// Outputs
			.dout		(dout_mealy),
			// Inputs
			.clk		(clk),
			.rst		(rst),
			.din		(din));
   
   moore_seq fsm_moore (/*AUTOINST*/
			// Outputs
			.dout		(dout_moore),
			// Inputs
			.clk		(clk),
			.rst		(rst),
			.din		(din));
     
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
