`timescale 1ns/1ns 
module tb_uart(); 
   localparam t = 8; //125MHz for ZyboZ7 
   logic clk; 
   logic rst; 

   localparam DBIT = 8;
   localparam SB_TICK = 16;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   logic [DBIT-1:0]	dout;			// From DUT of uart.v
   logic		rx_done_tick;		// From DUT of uart.v
   // End of automatics

   logic [7:0] din; // = 8'b01010110;
   logic [10:0] dvsr = 11'd66;
   logic 	tx_start;
   
   
   
   uart #(/*AUTOINSTPARAM*/
	  // Parameters
	  .DBIT				(DBIT),
	  .SB_TICK			(SB_TICK)) DUT (/*AUTOINST*/
							// Outputs
							.tx_done_tick   (tx_done_tick),
							.rx_done_tick	(rx_done_tick),
							.dout		(dout[DBIT-1:0]),
							// Inputs
							.clk		(clk),
							.rst		(rst),
							.din		(din[DBIT-1:0]),
							.dvsr		(dvsr[10:0]),
							.tx_start	(tx_start)); 
   
   initial clk = 1; 
   always #(t/2) clk = ~clk; 
   
   initial begin 
      rst = 1; 
      #(2*t); 
      rst = 0;
      #(t);
      tx_start = 1;
      #(2*t);
      tx_start = 0;
   end
   
   always@(posedge clk) begin
      for(int i= 0; i<20; i= i+1) begin
          din = $urandom();
          tx_start = 1;
          #(4*t);
          tx_start = 0;
          wait(rx_done_tick == 1);
          if(dout == din)begin
            $display("PASS ;) : tx = %d == rx = %d", din, dout);
          end else begin
            $display("FAIL ;( : tx = %d != rx = %d", din, dout);
            $finish;
          end
          wait(tx_done_tick == 1);
      end
      $finish;
   end 

   
   
   initial begin 
      $dumpfile("tb_uart.vcd"); 
      $dumpvars(0,tb_uart); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*" ".") 
// End:
