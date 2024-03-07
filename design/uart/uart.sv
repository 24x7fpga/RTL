`timescale 1ns/1ns 
module uart #(parameter DBIT = 8, SB_TICK = 16)(/*AUTOARG*/
   // Outputs
   tx_done_tick, rx_done_tick, dout,
   // Inputs
   clk, rst, din, dvsr, tx_start
   ); 
   input logic clk;
   input logic rst;
   input logic [DBIT-1: 0] din;
   input logic [10:0] 	   dvsr;
   input logic 		   tx_start;
   //input logic 	   rx;
   //output logic 	   tx;
   output logic tx_done_tick;
   output logic rx_done_tick;
   output logic [DBIT-1:0] dout;
   
 
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 
  // Beginning of automatic wires (for undeclared instantiated-module outputs)

  logic			s_tick;			// From BR of baud_rate.v
  logic			tx;			// From TX of uart_tx.v
  // End of automatics

   logic 		rx;

   assign rx = tx;
   
   baud_rate BR (/*AUTOINST*/
		 // Outputs
		 .s_tick		(s_tick),
		 // Inputs
		 .clk			(clk),
		 .rst			(rst),
		 .dvsr			(dvsr[10:0]));
 
   uart_tx #(/*AUTOINSTPARAM*/
	     // Parameters
	     .DBIT			(DBIT),
	     .SB_TICK			(SB_TICK)) TX (/*AUTOINST*/
						       // Outputs
						       .tx_done_tick	(tx_done_tick),
						       .tx		(tx),
						       // Inputs
						       .clk		(clk),
						       .rst		(rst),
						       .din		(din[7:0]),
						       .tx_start	(tx_start),
						       .s_tick		(s_tick)); 
   uart_rx #(/*AUTOINSTPARAM*/
	     // Parameters
	     .DBIT			(DBIT),
	     .SB_TICK			(SB_TICK)) RX (/*AUTOINST*/
						       // Outputs
						       .dout		(dout[7:0]),
						       .rx_done_tick	(rx_done_tick),
						       // Inputs
						       .clk		(clk),
						       .rst		(rst),
						       .rx		(rx),
						       .s_tick		(s_tick)); 
 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*" ".") 
// End:
