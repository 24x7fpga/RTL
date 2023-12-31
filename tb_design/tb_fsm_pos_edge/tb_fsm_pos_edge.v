`timescale 1ns/1ns 
module tb_fsm_pos_edge(); 
   localparam t = 10; 
   reg	      clk; 
   reg	      rst; 
   reg	      din;
 
   reg [0:20] seq = 21'b001100101100010011010;
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			dout_moore;			// From DUT_MOORE of fsm_pos_edge_moore.v, ...
   wire			dout_mealy;			// From DUT_MOORE of fsm_pos_edge_mealy.v, ...
   // End of automatics
   
   fsm_pos_edge_moore DUT_MOORE (/*AUTOINST*/
				 // Outputs
				 .dout			(dout_moore),
				 // Inputs
				 .clk			(clk),
				 .rst			(rst),
				 .din			(din)); 
   fsm_pos_edge_mealy DUT_MEALY (/*AUTOINST*/
				 // Outputs
				 .dout			(dout_mealy),
				 // Inputs
				 .clk			(clk),
				 .rst			(rst),
				 .din			(din)); 
   
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
      $dumpfile("tb_fsm_pos_edge.vcd"); 
      $dumpvars(0,tb_fsm_pos_edge); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
