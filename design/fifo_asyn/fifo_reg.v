`include "parameters.v"

`timescale 1ns/1ns
module fifo_reg(/*AUTOARG*/
   // Outputs
   rd_data,
   // Inputs
   wr_clk, wr_en, wr_full, rd_addr, wr_addr, wr_data
   );

   // outputs 
   output [`DATA_WIDTH-1:0] rd_data;
   // inputs
   input 		    wr_clk;
   input 		    wr_en;
   input                    wr_full;
   input [`ADDR_WIDTH-1:0]  rd_addr;
   input [`ADDR_WIDTH-1:0]  wr_addr;
   input [`DATA_WIDTH-1:0]  wr_data;

   reg [`DATA_WIDTH-1:0]    fifo_mem[0:`DEPTH-1];

   // write operation
   always@(posedge wr_clk)
     begin
	if(wr_en && !wr_full)
	  fifo_mem[wr_addr] <= wr_data;
     end

   //read operation
   assign rd_data = fifo_mem[rd_addr];

endmodule // fifo_reg
// Local Variables:
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
   
