`timescale 1ns/1ns 
module tb_assign_vs_if(); 

   logic [1:0] a, b;
   logic       sel;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [1:0]		c;			// From DUT of assign_vs_if.v
   logic [1:0]		d;			// From DUT of assign_vs_if.v
   // End of automatics
   assign_vs_if DUT (/*AUTOINST*/
		     // Outputs
		     .d			(d[1:0]),
		     .c			(c[1:0]),
		     // Inputs
		     .a			(a[1:0]),
		     .b			(b[1:0]),
		     .sel		(sel)); 

   initial begin
      sel = 1'b0;
      a   = 2'b10;
      b   = 2'b11;
      #5;

      sel = 1'b1;
      #5;

      sel = 1'bx;
      #5;

      sel = 1'bz;
      #5;

      sel = 1'bx;
      a   = 2'b00;
      b   = 2'b00;
      #5;

      sel = 1'bz;
      #5;
     
      sel = 1'bx;
      a   = 2'b11;
      b   = 2'b11;
      #5;
      
      sel = 1'bz;
      #5;
      
      $finish;
   end // initial begin
   
   initial begin 
      $dumpfile("tb_assign_vs_if.vcd"); 
      $dumpvars(0,tb_assign_vs_if); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/assign_vs_if" ".")
// End:
