`timescale 1ns/1ns 
module univ_shift_reg #(parameter N =4)(/*AUTOARG*/
   // Outputs
   dout,
   // Inputs
   din, sel, clk, rst
   );
   // outputs
   output [N-1:0] dout;
   // inputs
   input [N-1:0]  din;
   input [$clog2(N)-1:0] sel;
   input		 clk;
   input		 rst;
   
   /*AUTOREG*/ 
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [N-1:0]		dout;
   // End of automatics
   /*AUTOWIRE*/ 
 
 
   logic [N-1:0]	 mux_d;

   always_ff@(posedge clk)
     if(rst)
       dout <= 0; // N'h0
     else
       dout <= mux_d;

   always_comb begin
      case(sel)
	2'h0 : mux_d = dout;
	2'h1 : mux_d = {din[N-1],dout[N-1:1]};
	2'h2 : mux_d = {dout[N-2:0], din[0]};
	2'h3 : mux_d = din;
	default: mux_d = din;
      endcase // case (sel)
   end
   
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/univ_shift_reg" ".")
// End:
