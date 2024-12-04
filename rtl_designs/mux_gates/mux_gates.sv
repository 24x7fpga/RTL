`timescale 1ns/1ns 
module mux_gates(/*AUTOARG*/
   // Outputs
   t, u, v, w, x, y, z,
   // Inputs
   a, b
   );
   //outputs
   output t, u, v, w, x, y, z;

   //inputs
   input  a, b;
   
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 

   assign t = a ? 1'b0 : 1'b1; // inverter
   assign u = a ?    b : 1'b0; // and
   assign v = a ? 1'b1 : b;    // or
   assign w = b ?   ~a : 1'b1; // nand
   assign x = a ? 1'b0 : ~b;   // nor
   assign y = a ?   ~b : b;    // xor
   assign z = b ?    a : ~a;   // xnor 
 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
