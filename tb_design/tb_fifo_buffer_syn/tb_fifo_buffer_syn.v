`timescale 1ns/1ns
`include "parameters.v" 
module tb_fifo_buffer_syn(); 
   localparam t = 10; 
   reg clk; 
   reg rst; 
  
   reg wr, rd;
   reg [`DATA_WIDTH-1:0] data;

   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			al_empty;		// From DUT of fifo_buffer_syn.v
   wire			al_full;		// From DUT of fifo_buffer_syn.v
   wire			empty;			// From DUT of fifo_buffer_syn.v
   wire			full;			// From DUT of fifo_buffer_syn.v
   wire [`ADDR_WIDTH-1:0] rd_addr;		// From DUT of fifo_buffer_syn.v
   wire [`DATA_WIDTH-1:0] rd_data;		// From DUT of fifo_buffer_syn.v
   wire [`ADDR_WIDTH-1:0] wd_cnt;		// From DUT of fifo_buffer_syn.v
   // End of automatics
   
   fifo_buffer_syn DUT (/*AUTOINST*/
			// Outputs
			.rd_data	(rd_data[`DATA_WIDTH-1:0]),
			.rd_addr	(rd_addr[`ADDR_WIDTH-1:0]),
			.full		(full),
			.empty		(empty),
			.al_full	(al_full),
			.al_empty	(al_empty),
			.wd_cnt		(wd_cnt[`ADDR_WIDTH-1:0]),
			// Inputs
			.clk		(clk),
			.rst		(rst),
			.wr		(wr),
			.rd		(rd),
			.data		(data[`DATA_WIDTH-1:0])); 

   initial clk = 1; 
   always #(t/2) clk = ~clk; 

   // free flowing data 
   always begin
      for(k = 0; k < `DEPTH; k = k+1)begin
	 @(posedge clk) 
	 data <= $random%(2**`DATA_WIDTH);
      end
   end
   
   initial begin 
      rst <= 0; 
      #(2*t); 
      @(posedge clk)
      rst <= 1; 
   end 
   
   integer k;
 
   initial begin
      
      // write data fifo depth 
      wr <= 1;
      rd <= 0;
    
      for(k = 0; k < `DEPTH; k = k+1)begin
      	 @(posedge clk) 
	   wr <= 1;
      end
      
      #(2*`DEPTH*t);

      // read data fifo depth
      wr <= 0;
      for(k = 0; k < `DEPTH; k = k+1)begin
	 @(posedge clk)
	   rd <= 1; 
      end
      
      #(2*`DEPTH*t);
      
      
      //partial fifo write 
      rd <= 0;
      for(k = 0; k < (`DEPTH/2); k = k+1)begin
      	 @(posedge clk) 
	   wr <= 1;
      end
      
      #(`DEPTH/2*t);
      
      //partial fifo read 
      wr <= 0;
      for(k = 0; k < (`DEPTH/2); k = k+1)begin
      	 @(posedge clk) 
	   rd <= 1;
      end
      
      #((`DEPTH/3)*t);
      
      // enable write and read 
      wr <= 1;
      rd <= 1;
      #((`DEPTH/4)*t);
      
      // disable write and read 
      wr <= 0;
      rd <= 0;
      #((`DEPTH/4)*t);
      
      $finish;
   end 
   
   initial begin 
      $dumpfile("tb_fifo_buffer_syn.vcd"); 
      $dumpvars(0,tb_fifo_buffer_syn); 
   end
 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
