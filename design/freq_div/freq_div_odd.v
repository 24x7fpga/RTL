`timescale 1ns/1ns
module freq_div_odd #(parameter n = 3) (/*AUTOARG*/
   // Outputs
   div3, div5, div7,
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output div3;
   output div5;
   output div7;

   /*AUTOREG*/
   /*AUTOWIRE*/

   reg  [$clog2(n)-1:0] cnt_reg3, cnt_reg5, cnt_reg7;
   wire [$clog2(n)-1:0] cnt_nxt3, cnt_nxt5, cnt_nxt7;


   reg 			cnt3_q1, cnt5_q1, cnt7_q2;
   
   always@(posedge clk)
     begin
	if(!rst)begin
           cnt_reg3 <= 'h0;
	   cnt_reg5 <= 'h0;
	   cnt_reg7 <= 'h0;
	end else begin
	   cnt_reg3 <= cnt_nxt3;
	   cnt_reg5 <= cnt_nxt5;
	   cnt_reg7 <= cnt_nxt7;
	end
     end

   assign cnt_nxt3 = (cnt_reg3 == 2) ? 'h0 : cnt_reg3 + 'h1;
   assign cnt_nxt5 = (cnt_reg5 == 4) ? 'h0 : cnt_reg5 + 'h1;
   assign cnt_nxt7 = (cnt_reg7 == 6) ? 'h0 : cnt_reg7 + 'h1; // redundant

   // frequency divided by 3
   always@(negedge clk)
     begin
	cnt3_q1 <= cnt_reg3[1];
     end

   assign div3 = cnt_reg3[1] | cnt3_q1;

   //frequency divided by 5
   always@(negedge clk)
     begin
	cnt5_q1 <= cnt_reg5[1];
     end

   assign div5 = cnt_reg5[1] | cnt5_q1;

   //frequency divided by 7
   always@(negedge clk)
     begin
	cnt7_q2 <= cnt_reg7[2];
     end

   assign div7 = cnt_reg7[2] | cnt7_q2;

endmodule // freq_div_odd
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
