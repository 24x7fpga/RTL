 `include "parameters.v"

`timescale 1ns/1ns
module fifo_asyn(/*AUTOARG*/
   // Outputs
   rd_data, wr_full, rd_empty,
   // Inputs
   wr_clk, wr_en, wr_rst, rd_clk, rd_en, rd_rst, wr_data
   );

   // outputs
   output [`DATA_WIDTH-1:0] rd_data;
   output 		    wr_full;
   output 		    rd_empty;
   // inputs
   input 		    wr_clk, wr_en, wr_rst;
   input 		    rd_clk, rd_en, rd_rst;
   input [`DATA_WIDTH-1:0]  wr_data;

   /*AUTOREG*/

   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [`ADDR_WIDTH-1:0] rd_addr;		// From FIFO_RD of fifo_rd_ptr.v
   wire [`ADDR_WIDTH:0]	rd_ptr;			// From FIFO_RD of fifo_rd_ptr.v
   wire [`ADDR_WIDTH-1:0] wr_addr;		// From FIFO_WR of fifo_wr_ptr.v
   wire [`ADDR_WIDTH:0]	wr_ptr;			// From FIFO_WR of fifo_wr_ptr.v
   // End of automatics

  
   wire [`ADDR_WIDTH:0] w2r_wr_ptr, r2w_rd_ptr;
   
   // fifo register
   fifo_reg FIFO_REG (/*AUTOINST*/
		      // Outputs
		      .rd_data		(rd_data[`DATA_WIDTH-1:0]),
		      // Inputs
		      .wr_clk		(wr_clk),
		      .wr_en		(wr_en),
		      .wr_full		(wr_full),
		      .rd_addr		(rd_addr[`ADDR_WIDTH-1:0]),
		      .wr_addr		(wr_addr[`ADDR_WIDTH-1:0]),
		      .wr_data		(wr_data[`DATA_WIDTH-1:0]));

   // fifo write pointer and full condition
   fifo_wr_ptr FIFO_WR (/*AUTOINST*/
			// Outputs
			.wr_addr	(wr_addr[`ADDR_WIDTH-1:0]),
			.wr_ptr		(wr_ptr[`ADDR_WIDTH:0]),
			.wr_full	(wr_full),
			// Inputs
			.wr_clk		(wr_clk),
			.wr_rst		(wr_rst),
			.wr_en		(wr_en),
			.r2w_rd_ptr	(r2w_rd_ptr[`ADDR_WIDTH:0]));

   // fifo read pointer and empty condition
   fifo_rd_ptr FIFO_RD (/*AUTOINST*/
			// Outputs
			.rd_addr	(rd_addr[`ADDR_WIDTH-1:0]),
			.rd_ptr		(rd_ptr[`ADDR_WIDTH:0]),
			.rd_empty	(rd_empty),
			// Inputs
			.rd_clk		(rd_clk),
			.rd_rst		(rd_rst),
			.rd_en		(rd_en),
			.w2r_wr_ptr	(w2r_wr_ptr[`ADDR_WIDTH:0]));
   
   // synchronize registers from write to read
   fifo_sync SYNC_W2R (
		       // Outputs
		       .sync_out	(w2r_wr_ptr[`ADDR_WIDTH:0]),
		       // Inputs
		       .sync_clk	(rd_clk),
		       .sync_rst	(rd_rst),
		       .sync_in		(wr_ptr[`ADDR_WIDTH:0]));
   
   // synchronize registers from read to write
   fifo_sync SYNC_R2W (
		       // Outputs
		       .sync_out	(r2w_rd_ptr[`ADDR_WIDTH:0]),
		       // Inputs
		       .sync_clk	(wr_clk),
		       .sync_rst	(wr_rst),
		       .sync_in		(rd_ptr[`ADDR_WIDTH:0]));

endmodule // asyn_fifo
// Local Variables:
// Verilog-Library-Directories: (".")
// End:



   
