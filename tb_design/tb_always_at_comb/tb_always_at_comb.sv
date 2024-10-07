`timescale 1ns/1ns 
module tb_always_at_comb(); 

   localparam t = 10;
   
   logic [2:0] a, b;

   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [3:0]		y_a;			// From DUT of always_at_comb.v
   wire [3:0]		y_c;			// From DUT of always_at_comb.v
   wire [3:0]		z_a;			// From DUT of always_at_comb.v
   wire [3:0]		z_c;			// From DUT of always_at_comb.v
   // End of automatics
   always_at_comb DUT (/*AUTOINST*/
		       // Outputs
		       .y_a		(y_a[3:0]),
		       .z_a		(z_a[3:0]),
		       .y_c		(y_c[3:0]),
		       .z_c		(z_c[3:0]),
		       // Inputs
		       .a		(a[2:0]),
		       .b		(b[2:0])); 
   
   initial begin
      #(0) a = $urandom();
      #(0) b = $urandom();
      #(t) a = $urandom();
      #(t) b = $urandom();
   end 

   initial begin
      $monitor("At T = %0t, a = %d, b = %0d, y_a = %0d, y_c = %0d, z_a = %0d, z_c = %0d", $time, a, b, y_a, y_c, z_a, z_c);
   end
   
   
   initial begin 
      $dumpfile("tb_always_at_comb.vcd"); 
      $dumpvars(0,tb_always_at_comb); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
