`include "package.svh"
module tb_$ARG;
   // Clock
   logic      i_clk;
   
   /*AUTOREG*/
   /*AUTOWIRE*/

   // Add Interface
   $ARG_intf intf(i_clk);

   $ARG DUT (/*AUTOINST*/);

   // Generate Clock
   always #(`T/2) i_clk = (clk === 1'b0);

   initial begin
      intf.reset();

      // End Sim
      $finish;
   end

   initial begin
      $dumpfile("tb_$ARG.vcd");
      $dumpvars(0,tb_$ARG);
   end
   
endmodule // tb_$ARG
// Local Variables:
// Verilog-Library-Directories: (".")
// End:

      
   
   
   
