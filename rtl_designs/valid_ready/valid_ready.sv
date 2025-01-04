`include "package.svh"
module valid_ready #(parameter N = 4, V = 0) (/*AUTOARG*/
   // Outputs
   up_data, up_vld, dwn_rdy,
   // Inputs
   up_rdy, dwn_vld, dwn_data, clk, rst
   );
   // Outputs
   // up stream
   output [N-1:0] up_data;
   output	  up_vld;
   // down stream
   output	  dwn_rdy;
   // Inputs
   // up stream 
   input	  up_rdy;
   // down stream
   input	  dwn_vld;
   input [N-1:0]  dwn_data;

   input	  clk;
   input	  rst;
   
   /*AUTOREG*/
   /*AUTOWIRE*/
   
   generate
      if(V == 1) begin : Variation_1
	valid_ready_var1 #(/*AUTOINSTPARAM*/
			   // Parameters
			   .N			(N)) VAR1 (/*AUTOINST*/
							   // Outputs
							   .up_data		(up_data[N-1:0]),
							   .up_vld		(up_vld),
							   .dwn_rdy		(dwn_rdy),
							   // Inputs
							   .up_rdy		(up_rdy),
							   .dwn_vld		(dwn_vld),
							   .dwn_data		(dwn_data[N-1:0]),
							   .clk			(clk),
							   .rst			(rst));
      end else begin : Variation_2 
	valid_ready_var2 #(/*AUTOINSTPARAM*/
			   // Parameters
			   .N			(N)) VAR2 (/*AUTOINST*/
							   // Outputs
							   .up_data		(up_data[N-1:0]),
							   .up_vld		(up_vld),
							   .dwn_rdy		(dwn_rdy),
							   // Inputs
							   .up_rdy		(up_rdy),
							   .dwn_vld		(dwn_vld),
							   .dwn_data		(dwn_data[N-1:0]),
							   .clk			(clk),
							   .rst			(rst));
      end
   endgenerate
   
endmodule // valid_ready
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
