`timescale 1ns/1ns
module freq_div_even #(parameter n = 4) (/*AUTOARG*/
   // Outputs
   div2, div4, div6,
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output div2;
   output div4;
   output div6;

   /*AUTOREG*/
   /*AUTOWIRE*/

   reg  [$clog2(n)-1:0] cnt_reg, cnt_reg6;
   wire [$clog2(n)-1:0] cnt_nxt, cnt_nxt6;

   reg			cnt6_q1;

   always@(posedge clk)
     begin
	if(!rst)begin
	   cnt_reg  <= 'h0;
	   cnt_reg6 <= 'h0;
	end else begin
	   cnt_reg  <= cnt_nxt; // 
	   cnt_reg6 <= cnt_nxt6;
	end
     end // always@ (posedge clk)

   assign cnt_nxt  = cnt_reg + 'h1; // simple counter 
   assign cnt_nxt6 = (cnt_reg6 == 5) ? 'h0 : cnt_reg6 + 'h1;

   // frequency divided by 2
   assign div2 = cnt_reg[1];

   // frequency divided by 4
   assign div4 = cnt_reg [2];

   // frequency divided by 6
   always@(posedge clk)
     begin
	cnt6_q1 <= cnt_reg6[1];
     end

   assign div6 = cnt_reg6[2] | cnt6_q1;

endmodule // freq_div_even
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
