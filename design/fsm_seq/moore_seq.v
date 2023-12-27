//////////////////////////////////////////////
// Detect a sequence of 101 and 0010
//////////////////////////////////////////////

`timescale 1ns/1ns

module moore_seq(/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   clk, rst, din
   );
   input clk;
   input rst;
   input din;
   output dout;

   /*AUTOINPUT*/
   /*AUTOOUTPUT*/
   /*AUTOREG*/
   /*AUTOWIRE*/

   localparam [2:0] s0 = 'h0,
		    s1 = 'h1,
		    s2 = 'h2,
		    s3 = 'h3,
		    s4 = 'h4,
		    s5 = 'h5,
		    s6 = 'h6;

   reg [2:0]	    st_reg, st_nxt;

   always@(posedge clk)
     begin
	if(!rst)
	  st_reg <= s0;
	else
	  st_reg <= st_nxt;
     end

   always@(/*AUTOSENSE*/din or st_reg)
     begin
	st_nxt = st_reg;
	case(st_reg)
	  s0 : if(din)
	    st_nxt = s1;
	  else
	    st_nxt = s3;
	  s1 : if(din)
	    st_nxt = s1;
	  else
	    st_nxt = s2;
	  s2 : if(din)
	    st_nxt = s1;
	  else
	    st_nxt = s4;
	  s3 : if(din)
	    st_nxt = s1;
	  else
	    st_nxt = s4;
	  s4 : if(din)
	    st_nxt = s5;
	  else
	    st_nxt = s4;
	  s5 : if(din)
	    st_nxt = s1;
	  else
	    st_nxt = s2;
	  default: st_nxt = s0;
	endcase // case (st_reg)
     end // always@ (...

   assign dout = ((st_reg == s2 & din == 1) || (st_reg == s5 & din == 0));

endmodule // moore_seq
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
   
