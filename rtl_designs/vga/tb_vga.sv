`include "package.svh"
module tb_vga;
   // Clock
   logic      i_clk;
   
   /*AUTOREG*/
   /*AUTOWIRE*/

   // Add Interface
   vga_intf intf (i_clk);

   vga DUT (
	    // Inputs
	    .clk			(intf.clk),
	    .rst			(intf.rst));

   // Generate Clock
   always #(`T/2) i_clk = (i_clk === 1'b0);

   initial begin
      intf.reset();
      intf.run();
      // End Sim
      $finish;
   end

   initial begin
      $dumpfile("tb_vga.vcd");
      $dumpvars(0,tb_vga);
   end
   
endmodule // tb_vga
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
