`timescale 1ns/1ns 
module comparator #(parameter n = 4)(/*AUTOARG*/
   // Outputs
   gt, lt, et,
   // Inputs
   a, b
   ); 
   input [n-1:0] a, b;
   output      gt,lt,et;
 
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 

   assign et = (a == b) ? 1'b1 : 1'b0;
   assign gt = (a > b)  ? 1'b1 : 1'b0;
   assign lt = (a < b)  ? 1'b1 : 1'b0;
    
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/comparator" ".")
// End:
