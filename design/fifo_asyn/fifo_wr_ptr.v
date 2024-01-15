`include "parameters.v"

`timescale 1ns/1ns
module fifo_wr_ptr(/*AUTOARG*/
   // Outputs
   wr_addr, wr_ptr, wr_full,
   // Inputs
   wr_clk, wr_rst, wr_en, r2w_rd_ptr
   );

   // outputs
   output [`ADDR_WIDTH-1:0] wr_addr;
   output [`ADDR_WIDTH:0]   wr_ptr;
   output 		    wr_full;
   
   // inputs
   input 		    wr_clk, wr_rst, wr_en;
   input [`ADDR_WIDTH:0]    r2w_rd_ptr;

   // write address and pointer register 
   reg [`ADDR_WIDTH:0] 	    wr_bin_reg, wr_gry_reg;
   // write address and pointer counter
   wire [`ADDR_WIDTH:0]     wr_bin_nxt, wr_gry_nxt;
   

   // full register and wire
   reg 			    wr_ful_reg;
   wire 		    wr_ful_nxt;
   
   
   always@(posedge wr_clk)
     begin
	if(!wr_rst)begin
	   wr_gry_reg <= 'h0;
	   wr_bin_reg <= 'h0;
	   wr_ful_reg <= 'h0;
	end else begin
	   wr_gry_reg <= wr_gry_nxt;
	   wr_bin_reg <= wr_bin_nxt;
	   wr_ful_reg <= wr_ful_nxt;
	end
     end // always@ (posedge wr_clk)

   // write address counter: binary counter
   assign wr_bin_nxt = (wr_en && !wr_ful_reg) ? (wr_bin_reg + 'h1) : wr_bin_reg;

   // write pointer counter: gray counter
   assign wr_gry_nxt = (wr_bin_nxt >> 1) ^ wr_bin_nxt;
   
   // full condition
   assign wr_ful_nxt =  (wr_gry_nxt == {~r2w_rd_ptr[`ADDR_WIDTH:`ADDR_WIDTH-1], r2w_rd_ptr[`ADDR_WIDTH-2:0]});

   // assign outputs
   assign wr_addr = wr_bin_reg[`ADDR_WIDTH-1:0];
   assign wr_ptr  = wr_gry_reg;
   assign wr_full = wr_ful_reg;
   
endmodule // fifo_wr_ptr
// Local Variables:
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
   
   

 
