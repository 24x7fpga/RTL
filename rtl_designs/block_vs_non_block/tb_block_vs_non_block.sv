`define CLK_PERIOD 10

`timescale 1ns/1ns 
module tb_block_vs_non_block(); 
   logic clk; 
   logic rst; 
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   logic		x;			// From DUT of block_vs_non_block.v
   logic		xb;			// From DUT of block_vs_non_block.v
   logic		y;			// From DUT of block_vs_non_block.v
   logic		yb;			// From DUT of block_vs_non_block.v
   logic		z;			// From DUT of block_vs_non_block.v
   logic		zb;			// From DUT of block_vs_non_block.v
   // End of automatics

   block_vs_non_block DUT (/*AUTOINST*/
			   // Outputs
			   .x			(x),
			   .y			(y),
			   .z			(z),
			   .xb			(xb),
			   .yb			(yb),
			   .zb			(zb),
			   // Inputs
			   .clk			(clk),
			   .rst			(rst)); 
  
   always #(`CLK_PERIOD/2) clk = (clk === 1'b0);
 
   initial begin 
      rst = 1; 
      #(2*`CLK_PERIOD); 
      rst = 0;
      #(4*`CLK_PERIOD);
      $finish;
   end
   
   initial begin 
      $dumpfile("tb_block_vs_non_block.vcd"); 
      $dumpvars(0,tb_block_vs_non_block); 
   end
 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
