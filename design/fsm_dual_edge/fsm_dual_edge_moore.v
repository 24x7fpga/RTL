`timescale 1ns/1ns
module fsm_dual_edge_moore(/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   clk, rst, din
   );
   input clk;
   input rst;
   input din;
   output dout;

   /*AUTOREG*/
   /*AUTOWIRE*/

   localparam [1:0] s0 = 'h0,
		    s1 = 'h1,
		    s2 = 'h2,
		    s3 = 'h3;

   reg [1:0]	    st_reg, st_nxt;

   always@(posedge clk)
     begin
	if(!rst)
	  st_reg <= s0;
	else
	  st_reg <= st_nxt;
     end

   always@(/*AUTOSENSE*/din or st_reg)
     begin
	case(st_reg)
	  s0 : if(din)
	    st_nxt = s1;
	  else
	    st_nxt = s0;
	  s1 : if(din)
	    st_nxt = s2;
	  else
	    st_nxt = s3;
	  s2 : if(din)
	    st_nxt = s2;
	  else
	    st_nxt = s3;
	  s3 : if(din)
	    st_nxt = s1;
	  else
	    st_nxt = s0;
	  default : st_nxt = s0;
	endcase // case (st_reg)
     end // always@ (...

   assign dout = (st_reg == s1 || st_reg == s3);

endmodule // fsm_dual_edge_moore
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
