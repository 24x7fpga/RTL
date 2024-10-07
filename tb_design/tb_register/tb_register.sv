`timescale 1ns/1ns 
module tb_register(); 
   localparam t = 10; 
   logic      clk; 
   logic      rst;

   logic      d;
   
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			q;			// From DUT of register.v
   // End of automatics
   
   register DUT (/*AUTOINST*/
		 // Outputs
		 .q			(q),
		 // Inputs
		 .clk			(clk),
		 .rst			(rst),
		 .d			(d)); 
   
   always #(t/2) clk = (clk === 1'b0); 
   
   initial begin 
      rst = 1;
      d   = 0;
      #(2*t); 
      rst = 0;

      for(int i = 0; i < 40; i = i+1)begin
	 d=$random();
	 #(0.2 * $urandom_range(1,9) * t);
      end
      $finish;	   
   end 
   
   initial begin 
      $dumpfile("tb_register.vcd"); 
      $dumpvars(0,tb_register); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
