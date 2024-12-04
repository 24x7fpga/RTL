`timescale 1ns/1ns
module fsm_pos_edge_mealy(/*AUTOARG*/
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

   localparam s0 = 'h0,
	      s1 = 'h1;
   

   reg 	    st_reg, st_nxt;

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
	    st_nxt = s0;
	  s1 : if(din)
	    st_nxt = s1;
	  else
	    st_nxt = s0;
	endcase // case (st_reg)
     end // always@ (...

   assign dout = (st_reg == s0 && din == 1);

endmodule // fsm_pos_edge_mealy
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/fsm_pos_edge" ".")
// End: 
