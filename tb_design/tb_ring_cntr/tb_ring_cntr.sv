`timescale 1ns/1ns 
module tb_ring_cntr(); 
   localparam t = 10;
   localparam N = 4;
   
   logic      clk; 
   logic      rst; 
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [N-1:0]		sr_cntr;		// From DUT of ring_cntr.v
   wire [N-1:0]		tr_cntr;		// From DUT of ring_cntr.v
   // End of automatics
   
   ring_cntr DUT (/*AUTOINST*/
		  // Outputs
		  .sr_cntr		(sr_cntr[N-1:0]),
		  .tr_cntr		(tr_cntr[N-1:0]),
		  // Inputs
		  .clk			(clk),
		  .rst			(rst)); 
   
   always #(t/2) clk = (clk === 1'b0); 
   
   initial begin 
      rst = 1; 
      #(2*t); 
      rst = 0;
      $display("clk = %0t, rst = %0d --- Counter Start ---", $time, rst);
      repeat(2**N) begin
	 @(posedge clk);
	 $display("clk = %0t, Simple RC = %b, Twisted RC = %b", $time, sr_cntr, tr_cntr);
      end
      
      $finish;
   end 
   
   initial begin 
      $dumpfile("tb_ring_cntr.vcd"); 
      $dumpvars(0,tb_ring_cntr); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
