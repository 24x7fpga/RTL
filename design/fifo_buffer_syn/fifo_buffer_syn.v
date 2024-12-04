`timescale 1ns/1ns
`include "parameters.v" 
module fifo_buffer_syn(/*AUTOARG*/
   // Outputs
   rd_data, rd_addr, full, empty, al_full, al_empty, wd_cnt,
   // Inputs
   clk, rst, wr, rd, data
   ); 
   input clk; 
   input rst;

   input wr;
   input rd;

   input [`DATA_WIDTH-1:0] data;

   output [`DATA_WIDTH-1:0] rd_data;
   output [`ADDR_WIDTH-1:0] rd_addr;
  
   // status flags
   output 		    full;
   output 		    empty;
   output 		    al_full;
   output 		    al_empty;
   output [`ADDR_WIDTH-1:0] wd_cnt;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			rd_en;			// From FIFO_CTRL of fifo_buffer_ctrl.v
   wire [`ADDR_WIDTH-1:0] wr_addr;		// From FIFO_CTRL of fifo_buffer_ctrl.v
   wire [`DATA_WIDTH-1:0] wr_data;		// From FIFO_CTRL of fifo_buffer_ctrl.v
   wire			wr_en;			// From FIFO_CTRL of fifo_buffer_ctrl.v
   // End of automatics

   
   fifo_buffer_ctrl FIFO_CTRL (/*AUTOINST*/
			       // Outputs
			       .full		(full),
			       .empty		(empty),
			       .al_full		(al_full),
			       .al_empty	(al_empty),
			       .wr_en		(wr_en),
			       .rd_en		(rd_en),
			       .rd_addr		(rd_addr[`ADDR_WIDTH-1:0]),
			       .wr_addr		(wr_addr[`ADDR_WIDTH-1:0]),
			       .wr_data		(wr_data[`DATA_WIDTH-1:0]),
			       .wd_cnt		(wd_cnt[`ADDR_WIDTH-1:0]),
			       // Inputs
			       .clk		(clk),
			       .rst		(rst),
			       .wr		(wr),
			       .rd		(rd),
			       .data		(data[`DATA_WIDTH-1:0]));
   
   reg_file_dual_port MEM_FILE (/*AUTOINST*/
				// Outputs
				.rd_data	(rd_data[`DATA_WIDTH-1:0]),
				// Inputs
				.clk		(clk),
				.wr_en		(wr_en),
				.rd_en		(rd_en),
				.wr_addr	(wr_addr[`ADDR_WIDTH-1:0]),
				.rd_addr	(rd_addr[`ADDR_WIDTH-1:0]),
				.wr_data	(wr_data[`DATA_WIDTH-1:0]));
 

   
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/fifo_buffer_syn" ".")
// End: 
