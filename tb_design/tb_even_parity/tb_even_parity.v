`timescale 1ns/1ns 
module tb_even_parity();
   localparam t = 10;
   reg	      clk;
   reg	      rst;
   reg	      din;

   reg [15:0] seq = 16'b0101110010101111;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			dout;			// From DUT of even_parity.v
   // End of automatics

   even_parity DUT (/*AUTOINST*/
		    // Outputs
		    .dout		(dout),
		    // Inputs
		    .clk		(clk),
		    .rst		(rst),
		    .din		(din)); 
   initial clk = 1; 
   always #(t/2) clk = ~clk;

   initial begin
      rst = 0;
      #(2*t);
      rst = 1;
   end

   integer k;
 
   initial begin
      din = 0;
      wait(rst==1);
      #(t);
      for(k = 0; k < 16; k = k+1)begin
	 @(negedge clk) din = seq[k];
      end
      #(2*t);
      $finish;
   end 
   
   initial begin 
      $dumpfile("tb_even_parity.vcd"); 
      $dumpvars(0,tb_even_parity); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
