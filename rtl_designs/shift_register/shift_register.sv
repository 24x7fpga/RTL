`timescale 1ns/1ns 
module shift_register #(parameter N = 4)(/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   clk, rst, din
   );
   // Outputs
   output dout;
   // Inputs
   input clk; 
   input rst;
   input din;

   logic [N-1:0] regs; 
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 

   always_ff@(posedge clk)
      if(rst)
	regs <= 0;
      else
	regs <= {regs[N-2:0], din};

   assign dout = regs[N-1];		
 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
