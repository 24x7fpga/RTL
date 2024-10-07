`timescale 1ns/1ns 
module reg_file #(parameter width = 3)(/*AUTOARG*/
   // Outputs
   rd_data,
   // Inputs
   clk, wr_en, addr, wr_data
   ); 
   input clk;
   input wr_en;
   input [m-1:0] addr;
   input [n-1:0] wr_data;
   output [n-1:0] rd_data;
   
   localparam n = width,
              m = $clog2(width); 
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/

   reg [n-1:0] 	  data_reg [0:2**m-1];
   
  // write operation
     
  always@(posedge clk)
    begin
       if(wr_en)
	 data_reg[addr] <= wr_data;
    end

   // read operation
   
   assign rd_data = (wr_en) ? 'h0 : data_reg[addr];
	  
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
