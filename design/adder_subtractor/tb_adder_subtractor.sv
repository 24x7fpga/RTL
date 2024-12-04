`timescale 1ns/1ns

`include "add_sub.svh"
module tb_adder_subtractor();
   localparam t = 10;
   localparam N = 4;

   logic [N-1:0] a,b;
   logic	 ci;
   
   logic [N:0]	 exp_sum;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			co;			// From DUT of adder_subtractor.v
   wire [N-1:0]		sum;			// From DUT of adder_subtractor.v
   // End of automatics

   adder_subtractor DUT (/*AUTOINST*/
			 // Outputs
			 .sum			(sum[N-1:0]),
			 .co			(co),
			 // Inputs
			 .a			(a[N-1:0]),
			 .b			(b[N-1:0]),
			 .ci			(ci)); 

   initial begin
      repeat(30)begin
	 a = $urandom_range(1,2**N);
	 b = $urandom_range(1,2**N);
	 ci= $random;
	 exp_sum = add_sub(a,b,ci);
	 #t;
	 if(exp_sum[N-1:0] == sum)
	   $display("a=%0d, b=%0d, ctrl_sig=%0d, res=%0d", a, b, ci, sum);
	 else begin
	   $display("Simulation FAIL ;(");
	   $display("a=%0d, b=%0d, ctrl_sig=%0d, exp_res = %0d, res=%0d", a, b, ci, exp_sum[N-1:0], sum);
	 end
      end // repeat (30)
	 $display("Simulation PASS ;)"); 
   end 

   initial begin 
      $dumpfile("tb_adder_subtractor.vcd"); 
      $dumpvars(0,tb_adder_subtractor); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/adder_subtractor" ".")
// End:
