`include "parameters.v"

`timescale 1ns/1ns
module fifo_rd_ptr(/*AUTOARG*/
   // Outputs
   rd_addr, rd_ptr, rd_empty,
   // Inputs
   rd_clk, rd_rst, rd_en, w2r_wr_ptr
   );

   // outputs
   output [`ADDR_WIDTH-1:0] rd_addr;
   output [`ADDR_WIDTH:0]    rd_ptr;
   output 		    rd_empty;
   // inputs
   input 		    rd_clk, rd_rst, rd_en;
   input [`ADDR_WIDTH:0]    w2r_wr_ptr;

   // read address and pointer registers 
   reg [`ADDR_WIDTH:0] 	    rd_bin_reg, rd_gry_reg;
   // read address and pointer counter
   wire [`ADDR_WIDTH:0]     rd_bin_nxt, rd_gry_nxt;
   
   // empty register and wire
   reg 			    rd_emp_reg;
   wire 		    rd_emp_nxt;
   
   
   always@(posedge rd_clk)
     begin
	if(!rd_rst)begin
	   rd_gry_reg <= 'h0;
	   rd_bin_reg <= 'h0;
	   rd_emp_reg <= 'h1;
	end else begin
	   rd_gry_reg <= rd_gry_nxt;
	   rd_bin_reg <= rd_bin_nxt;
	   rd_emp_reg <= rd_emp_nxt;
	end
     end // always@ (posedge rd_clk)

   // read address counter: binary counter
   assign rd_bin_nxt = (rd_en && !rd_emp_reg) ? (rd_bin_reg + 'h1) : rd_bin_reg;

   // read pointer counter: gray counter
   assign rd_gry_nxt = (rd_bin_nxt>>1) ^ rd_bin_nxt;

   // empty condition
   assign rd_emp_nxt = (rd_gry_nxt == w2r_wr_ptr);

   // assign outputs
   assign rd_addr  = rd_bin_reg[`ADDR_WIDTH-1:0];
   assign rd_ptr   = rd_gry_reg;
   assign rd_empty = rd_emp_reg;

endmodule // fifo_rd_ptr
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
	   
   
   
