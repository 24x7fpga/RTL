`timescale 1ns/1ns 
module tb_manchester_scheme();
   localparam t = 10;
   reg clk;
   reg d_in;

   reg [9:0] temp = 'b01001100011;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			d_out;			// From DUT of manchester_scheme.v
   // End of automatics
 
   manchester_scheme DUT (/*AUTOINST*/
			  // Outputs
			  .d_out		(d_out),
			  // Inputs
			  .clk			(clk),
			  .d_in			(d_in)); 
   
   initial clk = 0; 
   always #(t/2) clk = ~clk; 

   initial begin 
      for (int i = 0; i < 10; i=i+1) begin
	 @(posedge clk) d_in = temp[i];
      end
      $finish;
   end
 
   initial begin 
      $dumpfile("tb_manchester_scheme.vcd"); 
      $dumpvars(0,tb_manchester_scheme); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
