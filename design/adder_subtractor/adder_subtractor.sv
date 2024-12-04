`timescale 1ns/1ns 
module adder_subtractor #(parameter N = 4)(/*AUTOARG*/
   // Outputs
   sum, co,
   // Inputs
   a, b, ci
   );
   // Outputs
   output [N-1:0] sum;
   output	  co;
   // Inputs
   input [N-1:0] a, b;
   input	 ci;    // control signal

   /*AUTOREG*/ 
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			co;
   reg [N-1:0]		sum;
   // End of automatics
   /*AUTOWIRE*/ 
   
   logic [N-1:0] b_s;
   logic [N:0] c;
    
   always_comb begin
      if(ci)begin
	 b_s = ~(b);
      end else begin
	 b_s = b;
      end
   end

   always_comb begin
      c[0] = ci;
      for(int i = 0; i < N; i = i+1)begin
	 sum[i] = (a[i] ^ b_s[i] ^ c[i]);
	 c[i+1] = (a[i] & b_s[i]) | (b_s[i] & c[i]) | (c[i] & a[i]);
      end
      co = c[N];
   end
   
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/adder_subtractor" ".")
// End:
