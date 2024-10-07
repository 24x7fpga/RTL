`timescale 1ns/1ns 
module tb_spi(); 
   localparam t = 8; 
   logic      clk; 
   logic      rst;

   localparam mode  = 3;
   localparam dvsr  = 31;
   localparam width = 8;

   logic [width-1:0] din;
   logic             tx_vld;
   
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [width-1:0]	rx_dout;		// From DUT of spi.v
   wire			rx_vld;			// From DUT of spi.v
   wire [width-1:0]	tx_dout;		// From DUT of spi.v
   // End of automatics
   spi #(/*AUTOINSTPARAM*/
	 // Parameters
	 .mode				(mode),
	 .dvsr				(dvsr),
	 .width				(width)) DUT (/*AUTOINST*/
						      // Outputs
						      .rx_vld		(rx_vld),
						      .rx_dout		(rx_dout[width-1:0]),
						      .tx_dout		(tx_dout[width-1:0]),
						      // Inputs
						      .clk		(clk),
						      .rst		(rst),
						      .din		(din[width-1:0]),
						      .tx_vld		(tx_vld)); 

   always #(t/2) clk = (clk === 1'b0); 
   initial begin 
      rst = 1;
      din ='h95;
      tx_vld = 0;
      #(2*t); 
      rst = 0;
      #(3*t);
      tx_vld = 1;
      wait(rx_vld);
      #(3*t);
      wait(rx_vld);
      $display("tx_dout = %0h and rx_dout = %0h", tx_dout, rx_dout);
      
      if(tx_dout == rx_dout)begin
	   $display("Simulation PASS ;)");
	   $finish;
	 end else begin
       $display("Simulation FAIL ;)");
	   $finish;
	 end 
   end // initial begin
   
   initial begin 
      $dumpfile("tb_spi.vcd"); 
      $dumpvars(0,tb_spi); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
