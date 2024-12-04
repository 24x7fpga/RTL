`timescale 1ns/1ns 
module tb_fsm_dual_edge(); 
   localparam t = 10; 
   reg	   clk; 
   reg     rst;
   reg	   din;

   reg [0:20] seq = 21'b001100101100010011010;
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			dout_mealy;		// From DUT of fsm_dual_edge.v
   wire			dout_moore;		// From DUT of fsm_dual_edge.v
   // End of automatics
   fsm_dual_edge DUT (/*AUTOINST*/
		      // Outputs
		      .dout_moore	(dout_moore),
		      .dout_mealy	(dout_mealy),
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
      $dumpfile("tb_fsm_dual_edge.vcd"); 
      $dumpvars(0,tb_fsm_dual_edge); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/fsm_dual_edge" ".")
// End:
