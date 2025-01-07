`include "package.svh"
module tb_latch_ff;
   // Clock
   logic      m_clk;
   
   /*AUTOREG*/
   /*AUTOWIRE*/

   // Add Interface
   latch_ff_intf intf (m_clk);

   latch_ff DUT (
		 // Outputs
		 .l_out			(intf.l_out),
		 .d_r_out		(intf.d_r_out),
		 .d_f_out		(intf.d_f_out),
		 // Inputs
		 .clk			(intf.clk),
		 .rst			(intf.rst),
		 .en			(intf.en),
		 .in			(intf.in));

   // Generate Clock
   always #(`T/2) m_clk = (m_clk === 1'b0);

   initial begin
      intf.reset();
      intf.run(); 
      // End Sim
      $finish;
   end

   initial begin
      repeat(1000) @(posedge m_clk);
      $display("Time Out");
      $finish;
   end
	
   initial begin
      $dumpfile("tb_latch_ff.vcd");
      $dumpvars(0,tb_latch_ff);
   end
   
endmodule // tb_latch_ff
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
