`timescale 1ns/1ns 
module tb_d_ff_en(); 
   localparam t = 10; // clock period
   reg clk; 
   reg rst;
   reg d;
   reg en;
 
 
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			q;			// From DUT of d_ff_en.v
   // End of automatics

   d_ff_en DUT (/*AUTOINST*/
		// Outputs
		.q			(q),
		// Inputs
		.d			(d),
		.clk			(clk),
		.rst			(rst),
		.en			(en)); 
   
   initial clk = 0; 
   always #(t/2) clk = ~clk; 

   initial begin
      rst = 1'b0;
      #(2*t);
      rst = 1'b1;
   end

   initial begin
      en = 1'b0;
      d  = 1'b1;
      @(posedge rst);
      @(negedge clk);
      en = 1'b1;
      repeat(4) @(negedge clk);
      en = 1'b0;
      repeat(2) @(negedge clk);
      en = 1'b1;
      d  = 1'b0;
      repeat(4) @(negedge clk);
      d  = 1'b1;
      repeat(4) @(negedge clk);
      d  = 1'b0;
      #(t);
      $finish;
   end // initial begin   
   
   initial begin 
      $dumpfile("tb_d_ff_en.vcd"); 
      $dumpvars(0,tb_d_ff_en); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
