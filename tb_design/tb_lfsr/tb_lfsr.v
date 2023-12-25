`timescale 1ns/1ns 
module tb_lfsr();
   localparam t = 10;
   localparam n = 8;

   reg	      clk;
   reg	      rst;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [1:n]		z;			// From DUT of lfsr.v
   // End of automatics
   lfsr #(.n(n)) DUT (/*AUTOINST*/
	  // Outputs
	  .z				(z[1:n]),
	  // Inputs
	  .clk				(clk),
	  .rst				(rst)); 
   
   initial clk = 0; 
   always #(t/2) clk = ~clk; 

   initial begin
      rst = 1'b0;
      #(2*t);
      rst = 1'b1;
   end

   initial begin
      #(4*t);		//
      wait(z==1)
      #(8*t);
      $finish;
   end // initial begin   
  
   initial begin 
      $dumpfile("tb_lfsr.vcd"); 
      $dumpvars(0,tb_lfsr); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
