`timescale 1ns/1ns 
module tb_reg_file(); 
   localparam t = 10;
   localparam width = 8;
   
   localparam n = width;
   localparam m = $clog2(width);
   
   reg clk; 
   reg rst;

   reg wr_en;
   reg [m-1:0] addr;
   reg [n-1:0] wr_data;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [n-1:0]		rd_data;		// From DUT of reg_file.v
   // End of automatics
   reg_file #(/*AUTOINSTPARAM*/
	      // Parameters
	      .width			(width)) DUT (/*AUTOINST*/
						      // Outputs
						      .rd_data		(rd_data[n-1:0]),
						      // Inputs
						      .clk		(clk),
						      .wr_en		(wr_en),
						      .addr		(addr[m-1:0]),
						      .wr_data		(wr_data[n-1:0])); 
   initial clk = 1; 
   always #(t/2) clk = ~clk; 
  
   initial begin 
      rst = 0; 
      #(t); 
      rst = 1; 
   end 
  
   
   integer k;
 
   initial begin
      //wr_en = 0;
      //wait(rst==1);
      //#(t);
      
      // write data
      wr_en = 1;
      for(k = 0; k < 2**m; k = k+1)begin
	 @(negedge clk) 
	 addr = k;
	 wr_data = $urandom%(2**n);
      end
      
      #(t);
      // read data
      wr_en = 0; 
      for(k = 0; k < 2**m; k = k+1)begin
	 @(negedge clk) 
	 addr = k;
      end
      
      #(t);
      
      $finish;
   end 
 
   initial begin 
      $dumpfile("tb_reg_file.vcd"); 
      $dumpvars(0,tb_reg_file); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
