`timescale 1ns/1ns 
module tb_univ_cntr(/*AUTOARG*/);
   localparam t = 10;
   localparam n = 4;
   
   reg [n-1:0] d_in;		// 
   reg	       ld;		//  
   reg	       up;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [n-1:0]		z;			// From DUT of univ_cntr.v
   // End of automatics
   
   reg			clk; 
   reg			rst; 
   
   univ_cntr #(.n(n)) DUT (/*AUTOINST*/
			   // Outputs
			   .z			(z[n-1:0]),
			   // Inputs
			   .clk			(clk),
			   .rst			(rst),
			   .d_in		(d_in[n-1:0]),
			   .ld			(ld),
			   .up			(up)); 
  
   
   initial clk = 0; 
   always #(t/2) clk = ~clk; 

   initial begin
      rst = 1'b0;
      #(2*t);
      rst = 1'b1;
   end

   initial d_in = 'h8;
      
   
   initial begin
      ld = 1'b0;
      up = 1'b1;
      repeat(10) @(negedge clk);
      wait (z==0);
      @(negedge clk);
      up = 1'b0;
      repeat(10) @(negedge clk);
      wait (z==5);
      @(negedge clk);
      ld = 1'b1;
      up = 1'b1;
      @(negedge clk);
      ld = 1'b0;
      #(21*t);
      @(negedge clk);
      ld = 1'b1;
      up = 1'b1;
      #(4*t);	
      $finish;
   end // initial begin   
   
   initial begin 
      $dumpfile("tb_univ_cntr.vcd"); 
      $dumpvars(0,tb_univ_cntr); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
