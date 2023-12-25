//////////////////////////////////////////////////
// Xilinx XAPP 052 : Table 3 for taps
//////////////////////////////////////////////////

`timescale 1ns/1ns 
module lfsr #(parameter n = 8)(/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   clk, rst
   );
   input clk;
   input rst;
   output [1:n] z;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/

   reg [1:n]	z_reg, z_nxt;
   wire 	shift;
   
   always@(posedge clk)
     begin
	if(!rst)
	  z_reg <= 'd1;
	else
	  z_reg <= z_nxt;
     end

   always@(/*AUTOSENSE*/shift or z_reg)
     begin
	z_nxt = {shift, z_reg[1:n-1]};
     end
   
   assign shift = z_reg[8] ^ z_reg[6] ^ z_reg[5] ^ z_reg[4];

   assign z = z_reg;
   
	
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
