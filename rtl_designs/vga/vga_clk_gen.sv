// For implementation use MCMM
`timescale 1ns/1ns

module vga_clk_gen #(parameter D = 5) (/*AUTOARG*/
   // Outputs
   pixel_clk,
   // Inputs
   clk, rst
   );
   // Outputs
   output pixel_clk;
   // Inputs
   input  clk;
   input  rst;

   /*AUTOWIRE*/
   /*AUTOREG*/

   logic [31:0] div = D; // default: 25Mhz clk for 640x480 @60hz

   logic [31:0]	cnt;
   
   
   always_ff@(posedge clk)
     if(rst)
       cnt <= 0;
     else
       cnt <= (cnt > div-1) ? '0 : cnt + 1;

   assign pixel_clk = (cnt <= div/2) ? 1'b1 : 1'b0;

endmodule // vga_clk_gen
 // Local Variables:
// Verilog-Library-Directories: (".")
// End:
 
