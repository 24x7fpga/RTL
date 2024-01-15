`timescale 1ns/1ns
`include "parameters.v" 
module tb_fifo_asyn(); 
   localparam t = 10; 
   reg wr_clk;
   reg rd_clk;
   reg wr_rst;
   reg rd_rst; 
  
   reg wr_en, rd_en;
   reg [`DATA_WIDTH-1:0] wr_data;

   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [`DATA_WIDTH-1:0] rd_data;		// From DUT of fifo_asyn.v
   wire			rd_empty;		// From DUT of fifo_asyn.v
   wire			wr_full;		// From DUT of fifo_asyn.v
   // End of automatics
   
   fifo_asyn DUT (/*AUTOINST*/
		  // Outputs
		  .rd_data		(rd_data[`DATA_WIDTH-1:0]),
		  .wr_full		(wr_full),
		  .rd_empty		(rd_empty),
		  // Inputs
		  .wr_clk		(wr_clk),
		  .wr_en		(wr_en),
		  .wr_rst		(wr_rst),
		  .rd_clk		(rd_clk),
		  .rd_en		(rd_en),
		  .rd_rst		(rd_rst),
		  .wr_data		(wr_data[`DATA_WIDTH-1:0])); 

   // write clock
   initial wr_clk = 1; 
   always #(t/2) wr_clk = ~wr_clk; 

   // read clock
   initial rd_clk = 1;
   always #(2*t/2) rd_clk = ~rd_clk;
  
   integer k;
   
   // initial wr_data
   initial wr_data <= 'h0;
   // free flowing data 
   always begin
      for(k = 0; k < `DEPTH; k = k+1)begin
	 //if(wr_en)
	   @(posedge wr_clk) wr_data <= $random%(2**`DATA_WIDTH);
      end
   end
   
   initial begin 
      wr_rst <= 0;
      #(2*t); 
      @(posedge wr_clk)
      wr_rst <= 1;
   end 
  

   initial begin 
      rd_rst <= 0;
      #(2*t); 
      @(posedge rd_clk)
      rd_rst <= 1;
   end 
 
   initial begin
      
      // write data fifo depth 
      wr_en <= 1;
      rd_en <= 0;
    
      for(k = 0; k < `DEPTH; k = k+1)begin
      	 @(posedge wr_clk) 
	   wr_en <= 1;
      end
      
      #(2*`DEPTH*t);

      // read data fifo depth
      wr_en <= 0;
      for(k = 0; k < `DEPTH; k = k+1)begin
	 @(posedge rd_clk)
	   rd_en <= 1; 
      end
      
      #(2*`DEPTH*t);
      
      
      //partial fifo write 
      rd_en <= 0;
      for(k = 0; k < (`DEPTH/2); k = k+1)begin
      	 @(posedge wr_clk) 
	   wr_en <= 1;
      end
      
      #(`DEPTH/2*t);
      
      //partial fifo read 
      wr_en <= 0;
      for(k = 0; k < (`DEPTH/2); k = k+1)begin
      	 @(posedge rd_clk) 
	   rd_en <= 1;
      end
      
      #((`DEPTH/3)*t);
      
      // enable write and read 
      wr_en <= 1;
      rd_en <= 1;
      #((`DEPTH/4)*t);
      
      // disable write and read 
      wr_en <= 0;
      rd_en <= 0;
      #((`DEPTH/4)*t);
      
      $finish;
   end 
   
   initial begin 
      $dumpfile("tb_fifo_asyn.vcd"); 
      $dumpvars(0,tb_fifo_asyn); 
   end
 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
