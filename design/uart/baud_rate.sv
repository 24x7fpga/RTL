//          Baud rate generator
//----------------------------------------
// The value of dvsr is 'n'. The counter
// implemented runs from 0 to n, therfore,
// is a mod(n+1) counter. If the baud rate
// is 'b' and frequency is 'f' then the
// desired sampling rate becomes 16 * b.
// Therefore, the dvsr = n :
//
//       n + 1 =  f / (16 * b)
//
//           n = {f / (16 * b)} -1
//
`timescale 1ns/1ns
module baud_rate(/*AUTOARG*/
   // Outputs
   s_tick,
   // Inputs
   clk, rst, dvsr
   );
   input logic clk;
   input logic rst;
   input logic [10:0] dvsr;
   output logic       s_tick;

   /*AUTOREG*/

   /*AUTOWIRE*/

   logic [10:0]       cnt_reg, cnt_nxt;

   always_ff@(posedge clk, posedge rst)
     if(rst)
       cnt_reg <= 0;
     else
       cnt_reg <= cnt_nxt;

   assign cnt_nxt = (cnt_reg == dvsr) ? 0 : cnt_reg + 1;

   assign s_tick = (cnt_reg == 1);

endmodule // baud_rate
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*" ".") 
// End:
