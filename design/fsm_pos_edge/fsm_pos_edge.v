`timescale 1ns/1ns 
module fsm_pos_edge(/*AUTOARG*/
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
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			dout_moore;			// From moore of fsm_pos_edge_moore.v, ...
   wire			dout_mealy;			// From moore of fsm_pos_edge_mealy.v, ...
   // End of automatics
   
   fsm_pos_edge_moore moore (/*AUTOINST*/
			     // Outputs
			     .dout		(dout_moore),
			     // Inputs
			     .clk		(clk),
			     .rst		(rst),
			     .din		(din)); 
   fsm_pos_edge_mealy mealy (/*AUTOINST*/
			     // Outputs
			     .dout		(dout_mealy),
			     // Inputs
			     .clk		(clk),
			     .rst		(rst),
			     .din		(din));
 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/fsm_pos_edge" ".")
// End:
