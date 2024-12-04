`timescale 1ns/1ns 
module equals(/*AUTOARG*/
   // Outputs
   two_e, three_e,
   // Inputs
   a, b
   );
   // outputs
   output two_e;
   output three_e;
   // input
   input [3:0] a;
   input [3:0] b;
 
   /*AUTOREG*/ 
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			three_e;
   reg			two_e;
   // End of automatics
   /*AUTOWIRE*/ 

   always_comb begin
      two_e   = (a == b);
      three_e = (a === b);
   end
   
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
