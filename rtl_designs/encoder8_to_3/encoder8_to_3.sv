`timescale 1ns/1ns 
module encoder8_to_3 #(parameter width = 8)(/*AUTOARG*/
   // Outputs
   out,
   // Inputs
   in
   ); 
   //outputs
   output [$clog2(width)-1:0] out;
   //inputs
   input [width-1:0]	     in;
   
 
  /*AUTOREG*/ 
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg [$clog2(width)-1:0] out;
  // End of automatics
  /*AUTOWIRE*/ 
 

   always_comb begin
      out = 'h0;
      
      for(int i = 0; i < width ; i = i+1) begin
	 if(in[i])
	   out = i;
      end
   end
   
 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
