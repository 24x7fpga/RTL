`timescale 1ns/1ns 
module tb_equals();

   logic [3:0] a,b;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			three_e;		// From DUT of equals.v
   wire			two_e;			// From DUT of equals.v
   // End of automatics
   
   equals DUT (/*AUTOINST*/
	       // Outputs
	       .two_e			(two_e),
	       .three_e			(three_e),
	       // Inputs
	       .a			(a[3:0]),
	       .b			(b[3:0])); 
   
   initial begin 
      a = 4'b000x;
      b = 4'b0x10;
      #5;
      a = 4'bxxxx;
      b = 4'bxxxx;
      #5;
      a = 4'b1x0x;
      b = 4'b1x0x;
      #5;
      a = 4'bx1xx;
      b = 4'bx0xx;
      #5;
      a = 4'b1010;
      b = 4'b1010;
      #5;
      a = 4'b1x10;
      b = 4'b1x10;
      #5;
      $finish;
   end 
   
   initial begin 
      $dumpfile("tb_equals.vcd"); 
      $dumpvars(0,tb_equals); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/equals" ".")
// End:
