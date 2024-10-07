`timescale 1ns/1ns 
module edge_detect(/*AUTOARG*/
   // Outputs
   posEdge, negEdge, dualEdge,
   // Inputs
   clk, rst, din
   );
   input clk;
   input rst;
   input din;
   output posEdge;
   output negEdge;
   output dualEdge;
   
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/

   reg	  din_reg;

   always@(posedge clk)
     begin
	if(!rst)
	  din_reg <= 'h0;
	else
	   din_reg <= din;
     end

   // Posedge detection
   assign posEdge = (~din_reg) & din;
   
   // Negedge detection
   assign negEdge = din_reg & (~din);
  
   // Dualedge detection
   assign dualEdge = posEdge || negEdge;
   
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
