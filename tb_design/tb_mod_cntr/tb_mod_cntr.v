`timescale 1ns/1ns 
module tb_mod_cntr();
   localparam n = 32;   // mod N
   localparam t = 10;  // clock period in ns
   
   reg	      clk;
   reg	      rst;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [$clog2(n)-1:0]	z;			// From DUT of mod_cntr.v
   // End of automatics
   mod_cntr #(.n(n)) DUT (/*AUTOINST*/
			  // Outputs
			  .z			(z[$clog2(n)-1:0]),
			  // Inputs
			  .clk			(clk),
			  .rst			(rst)); 
   
   initial clk = 0; 
   always #(t/2) clk = ~clk; 

   initial begin
      rst = 1'b0;
      #(2*t);
      rst = 1'b1;
   end

   initial begin
      #(4*t);		//
      wait(z==n)
      #(8*t);
      $finish;
   end // initial begin   
   
   initial begin 
      $dumpfile("tb_mod_cntr.vcd"); 
      $dumpvars(0,tb_mod_cntr); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
