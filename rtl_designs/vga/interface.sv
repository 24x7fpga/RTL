`include "package.svh"
interface vga_intf (input i_clk);
   // Clock
   logic clk;
   // Reset
   logic rst;

   // Add all the signals


   assign clk = i_clk;
   
   task reset();
      rst <= 1'b1;
      repeat (4) @(posedge clk);
      rst <= 1'b0;
   endtask // reset

   task run();
      repeat(10000000)
	#(`T);
   endtask // run

endinterface // vga_intf
