`include "package.svh"
module valid_ready_pipeline #(parameter N = 4, P = 4, V = 0) (/*AUTOARG*/
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

   logic [N-1:0]  s_up_data [0:P-1];
   logic [N-1:0]  s_dwn_data[0:P-1];
   logic [P-1:0]  s_dwn_rdy, s_dwn_vld;
   logic [P-1:0]  s_up_rdy, s_up_vld;

   generate
      if(V == 1) begin: Variation_1
	    genvar i;
	    // instantiate valid-ready
	    for(i = 0; i < P; i = i+1)begin
	       valid_ready_var1 #(.N(N)) VR_PIPE1 (
						   // Outputs
						   .up_data		(s_up_data[i]),
						   .up_vld		(s_up_vld[i]),
						   .dwn_rdy		(s_dwn_rdy[i]),
						   // Inputs
						   .up_rdy		(s_up_rdy[i]),
						   .dwn_vld		(s_dwn_vld[i]),
						   .dwn_data	        (s_dwn_data[i]),
						   .clk	        	(clk),
						   .rst		        (rst));
	    end // for (i = 0; i < P; i = i+1)

	    // connect the signals
	    for(i = 1; i < P; i = i+1)begin
	       // up stream
	       assign s_dwn_data[i] = s_up_data[i-1];
	       assign s_dwn_vld[i]  = s_up_vld[i-1];
	       // down stream
	       assign s_up_rdy[i-1] = s_dwn_rdy[i];
	    end
      end else begin : Variation_2 // block: Variation_1
	    genvar i;
	    // instantiate valid-ready
	    for(i = 0; i < P; i = i+1)begin
	       valid_ready_var2 #(.N(N)) VR_PIPE2 (
						   // Outputs
						   .up_data		(s_up_data[i]),
						   .up_vld		(s_up_vld[i]),
						   .dwn_rdy		(s_dwn_rdy[i]),
						   // Inputs
						   .up_rdy		(s_up_rdy[i]),
						   .dwn_vld		(s_dwn_vld[i]),
						   .dwn_data    	(s_dwn_data[i]),
						   .clk		        (clk),
						   .rst		        (rst));
	    end // for (i = 0; i < P; i = i+1)

	    // connect the signals
	    for(i = 1; i < P; i = i+1)begin
	       // up stream
	       assign s_dwn_data[i] = s_up_data[i-1];
	       assign s_dwn_vld[i]  = s_up_vld[i-1];
	       // down stream
	       assign s_up_rdy[i-1] = s_dwn_rdy[i];
	    end
      end // block: Variation_2
   endgenerate

   // up stream
   assign s_dwn_data[0] = dwn_data;
   assign s_dwn_vld[0]  = dwn_vld; 
   assign dwn_rdy       = s_dwn_rdy[0];
   
   // down stream 
   assign up_data       = s_up_data[P-1];
   assign up_vld        = s_up_vld[P-1];
   assign s_up_rdy[P-1] = up_rdy;

endmodule // valid_ready_pipeline
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
