`timescale 1ns/1ns 
module fsm_dual_edge(/*AUTOARG*/
   // Outputs
   dout_moore, dout_mealy,
   // Inputs
   clk, rst, din
   );
   input clk;
   input rst;
   input din;
   output dout_moore;
   output dout_mealy;
   
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			dout_moore;			// From moore of fsm_dual_edge_moore.v, ...
wire			dout_mealy;			// From moore of fsm_dual_edge_mealy.v, ...
// End of automatics
 fsm_dual_edge_moore moore (/*AUTOINST*/
			    // Outputs
			    .dout		(dout_moore),
			    // Inputs
			    .clk		(clk),
			    .rst		(rst),
			    .din		(din)); 
 fsm_dual_edge_mealy mealy (/*AUTOINST*/
			    // Outputs
			    .dout		(dout_mealy),
			    // Inputs
			    .clk		(clk),
			    .rst		(rst),
			    .din		(din)); 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End: 
