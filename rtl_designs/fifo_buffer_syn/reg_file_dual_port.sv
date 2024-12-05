`timescale 1ns/1ns
`include "parameters.v"
module reg_file_dual_port (/*AUTOARG*/
   // Outputs
   rd_data,
   // Inputs
   clk, wr_en, rd_en, wr_addr, rd_addr, wr_data
   );

   input clk;
   input wr_en;
   input rd_en;
   input [`ADDR_WIDTH-1:0] wr_addr;
   input [`ADDR_WIDTH-1:0] rd_addr;
   input [`DATA_WIDTH-1:0] wr_data;
   
   output [`DATA_WIDTH-1:0] rd_data;

   /*AUTOREG*/
   /*AUTOWIRE*/

   reg [`DATA_WIDTH-1:0] 	  fifo_reg [0:`DEPTH-1];

   // write operation
   always@(posedge clk)
     begin
	if(wr_en)
	  fifo_reg[wr_addr] <= wr_data;
     end

   // read operation
   assign rd_data = (rd_en) ? fifo_reg[rd_addr] : 'h0;

endmodule // reg_file_dual_port
// Local Variables: 
// Verilog-Library-Directories: (".")
// End: 
