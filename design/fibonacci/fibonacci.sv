`timescale 1ns/1ns 
module fibonacci #(parameter N = 16)(/*AUTOARG*/
   // Outputs
   f_num,
   // Inputs
   clk, rst, en
   ); 
   input clk; 
   input rst;
   input en;
   output [N-1:0] f_num;
   
 
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 

   logic [N-1:0]  reg1, reg2, reg3;
   
   always_ff@(posedge clk)
     begin
	if(~rst)begin
	   reg1 <= 'h0;
	   reg2 <= 'h1;
	end else begin
	   if(en)begin
	      reg1 <= reg2;
	      reg2 <= reg3;
	   end
	end
     end // always_ff@ (posedge clk)

   assign reg3 = reg1 + reg2;
   	
   assign f_num = reg3;
   
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
