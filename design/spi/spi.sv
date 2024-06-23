`timescale 1ns/1ns 
module spi #(parameter mode = 0, dvsr = 31, width = 8)(/*AUTOARG*/
   // Outputs
   rx_vld, rx_dout, tx_dout,
   // Inputs
   clk, rst, din, tx_vld
   ); 
   input  clk; 
   input  rst;
   input [width-1:0] din;
   input	     tx_vld;
   output	     rx_vld;
   output [width-1:0] rx_dout;
   output [width-1:0] tx_dout;
   
   
 
 
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire			cs;			// From MOD1 of spi_tx.v
  wire			miso;			// From MOD1 of spi_rx.v
  wire			mosi;			// From MOD1 of spi_tx.v
  wire			sclk;			// From MOD1 of spi_tx.v
  wire			tx_rdy;			// From MOD1 of spi_tx.v
  // End of automatics
 
spi_tx #(/*AUTOINSTPARAM*/
	 // Parameters
	 .mode				(mode),
	 .dvsr				(dvsr),
	 .width				(width)) SPI_MASTER (/*AUTOINST*/
						       // Outputs
						       .mosi		(mosi),
						       .sclk		(sclk),
						       .cs		(cs),
						       .tx_dout		(tx_dout[width-1:0]),
						       .tx_rdy		(tx_rdy),
						       .rx_vld		(rx_vld),
						       .din		(din[width-1:0]),
						       // Inputs
						       .miso		(miso),
						       .tx_vld		(tx_vld),
						       .rst		(rst),
						       .clk		(clk)); 
spi_rx #(/*AUTOINSTPARAM*/
	 // Parameters
	 .mode				(mode),
	 .width				(width)) SPI_SLAVE (/*AUTOINST*/
						       // Outputs
						       .miso		(miso),
						       .rx_dout		(rx_dout[width-1:0]),
						       // Inputs
						       .mosi		(mosi),
						       .sclk		(sclk),
						       .cs		(cs),
						       .rst		(rst),
						       .clk		(clk)); 
 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
