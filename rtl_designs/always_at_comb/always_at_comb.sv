`timescale 1ns/1ns 
module always_at_comb(/*AUTOARG*/
   // Outputs
   y_a, z_a, y_c, z_c,
   // Inputs
   a, b
   ); 
   // Outputs
   output [3:0] y_a, z_a;
   output [3:0] y_c, z_c;
   // Inputs
   input [2:0]	a, b;
   
   /*AUTOREG*/ 
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [3:0]		y_a;
   reg [3:0]		y_c;
   reg [3:0]		z_a;
   reg [3:0]		z_c;
   // End of automatics
   /*AUTOWIRE*/ 

   // sensitive to only changes in the list
   always@(a)
     y_a = a + b;

   // execute at zero time
   always_comb
     y_c = a + b;

   function logic [3:0] func_add (logic [2:0] b);
      return a + b;
   endfunction // mul

   // sensitive only to the arguments of a function
   always@(*)
     z_a = func_add(b);

   // sensitive to any changes of the function
   always_comb
     z_c = func_add(b);
   
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
