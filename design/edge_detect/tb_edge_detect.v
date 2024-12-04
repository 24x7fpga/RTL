`timescale 1ns/1ns 
module tb_edge_detect(); 
   localparam t = 10; 
   reg	      clk; 
   reg	      rst;

   reg	      din;
  
   reg [0:20] seq = 21'b001100101100010011010;
  
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			dualEdge;		// From DUT of edge_detect.v
   wire			negEdge;		// From DUT of edge_detect.v
   wire			posEdge;		// From DUT of edge_detect.v
   // End of automatics
   edge_detect DUT (/*AUTOINST*/
		    // Outputs
		    .posEdge		(posEdge),
		    .negEdge		(negEdge),
		    .dualEdge		(dualEdge),
		    // Inputs
		    .clk		(clk),
		    .rst		(rst),
		    .din		(din)); 
   initial clk = 1; 
   always #(t/2) clk = ~clk; 
   
   initial begin 
      rst = 0; 
      #(2*t); 
      rst = 1; 
   end 

   integer k;
 
   initial begin
      din = 0;
      wait(rst==1);
      #(t);
      for(k = 0; k < 21; k = k+1)begin
	 @(negedge clk) din = seq[k];
      end
      #(2*t);
      $finish;
   end 
   
   initial begin 
      $dumpfile("tb_edge_detect.vcd"); 
      $dumpvars(0,tb_edge_detect); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/edge_detect" ".")
// End:
