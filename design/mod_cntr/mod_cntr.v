`timescale 1ns/1ns 
module mod_cntr #(parameter n = 4)(/*AUTOARG*/
   // Inputs
   clk, rst, z
   );
   input clk;
   input rst;
   output [$clog2(n)-1:0]	z; // 
    
   /*AUTOREG*/ 
   /*AUTOWIRE*/

   reg [$clog2(n)-1:0]	z_reg, z_nxt;

   always@(posedge clk)
     begin
	if(!rst)
	  z_reg <= 'h0;
	else
	  z_reg <= z_nxt;
     end
   
   always@(/*AUTOSENSE*/z_reg)
     begin
	z_nxt = (z_reg==n) ? 'h0 : z_reg + 1;
     end

   assign z = z_reg;
	
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
