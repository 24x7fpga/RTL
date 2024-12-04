`include "package.svh"
interface $ARG_intf (input i_clk);
   // Reset
   logic i_rst;

   // Add all the signals


   task reset();
      i_rst <= 1'b0;
      repeat (4) @(posedge i_clk);
      i_rst <= 1'b1;
   endtask // reset

endinterface // $ARG_intf

   
