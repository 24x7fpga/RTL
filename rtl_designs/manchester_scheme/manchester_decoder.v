//////////////////////////////////////////////////
// Assuming the transmitter and receiver have
//             the same clock
//////////////////////////////////////////////////

`timescale 1ns/1ns
module manchester_decoder (/*AUTOARG*/
   // Outputs
   d_decod,
   // Inputs
   clk, rst, d_encod
   );

   input clk;
   input rst;
   input d_encod;

   output d_decod;

   localparam s0 = 'h0, // 0
              s1 = 'h1; // 1
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			d_decod;
   // End of automatics
   /*AUTOWIRE*/
   

   reg 	  st_reg, st_nxt;
   
   always@(negedge clk)
     begin
	if(!rst)
	  st_reg <= s0;
	else
	  st_reg <= st_nxt;
     end

   always@(/*AUTOSENSE*/d_encod or st_reg)
     begin
	st_nxt = st_reg;
	case(st_reg)
	  s0 : if(d_encod)
	    st_nxt = s1;
	  else
	    st_nxt = s0;
	  s1 : if(d_encod)
	    st_nxt = s1;
	  else
	    st_nxt = s0;
	endcase // case (st_reg)
     end // always@ (...

  always@(posedge clk)
    begin
       if(st_reg == s1)
	 d_decod <= 'h1;
       if(st_reg == s0)
	 d_decod <= 'h0;
    end
   
endmodule // manchester_decoder
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
   
