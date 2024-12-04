`timescale 1ns/1ns 
module tb_clk_gating(); 
   localparam t = 10; 
   logic      clk;

   logic      en;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			g_clk;			// From DUT of clk_gating.v
   wire			g_clk_glitch;		// From DUT of clk_gating.v
   // End of automatics
   
   clk_gating DUT (/*AUTOINST*/
		   // Outputs
		   .g_clk_glitch	(g_clk_glitch),
		   .g_clk		(g_clk),
		   // Inputs
		   .clk			(clk),
		   .en			(en)); 
   
   always #(t/2) clk = (clk === 1'b0); 
   
   initial begin 
      en = 0; 
      #(t);
      
      #(t/2 + 2);
      en = 1;
      #(t/2 + 1);
      en = 0;
      #(t/2 + 1);
      en = 1;
      #(t/2 - 2);
      en = 0;
      #(t/2 + 2);
      en = 1;
      #(t   * 4);
      $finish;
   end 
   
   initial begin 
      $dumpfile("tb_clk_gating.vcd"); 
      $dumpvars(0,tb_clk_gating); 
   end 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
