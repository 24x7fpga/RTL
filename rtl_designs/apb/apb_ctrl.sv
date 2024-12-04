module apb_ctrl(/*AUTOARG*/
   // Outputs
   pready, prdata,
   // Inputs
   paddr, pwdata, pselx, penable, pwrite, pclk, presetn
   );
   // outputs
   // APB signals
   output logic            pready;
   output [`WIDTH-1:0]	   prdata;
   
   
   // UART signals
      
   // inputs
   // APB signals
   input [`WIDTH-1:0] paddr;
   input [`WIDTH-1:0] pwdata;
   input [3:0]	      pselx;
   input	      penable;
   input	      pwrite;

   // common signals
   input	      pclk;
   input	      presetn;

   // UART signals
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [`WIDTH-1:0]	prdata;
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   logic		rx_busy;		// From UART_TOP of uart.v
   logic		rx_done_tick;		// From UART_TOP of uart.v
   logic		tx_busy;		// From UART_TOP of uart.v
   logic		tx_done_tick;		// From UART_TOP of uart.v
   // End of automatics

   
   logic [`DBIT-1:0]	dout;
   logic [`DBIT-1:0]	din;
   logic [10:0]		dvsr;
   logic		tx_start;
   
   // instantiate UART module
   uart #(
	  // Parameters
	  .DBIT		(`DBIT),
	  .SB_TICK	(`SB_TICK)) UART_TOP (
					      // Outputs
					      .tx_busy		(tx_busy),
					      .rx_busy		(rx_busy),
					      .tx_done_tick	(tx_done_tick),
					      .rx_done_tick	(rx_done_tick),
					      .dout		(dout[`DBIT-1:0]),
					      // Inputs
					      .clk		(clk),
					      .rst		(rst),
					      .din		(din[`DBIT-1:0]),
					      .dvsr		(dvsr[10:0]),
					      .tx_start		(tx_start));

   // assign clk and reset
   assign clk = pclk;
   assign rst = !presetn;
  
   // pready signal (additional slaves logic can be added)
   // pselx[0] verifying the master transmission
   // pselx[1] verifying the uart tx and rx
   always_ff @(posedge pclk) begin
      if(!presetn) begin
	 pready <= 0;
      end else begin
      if(pselx == 1)
	pready <= 1'd1;
      else if(pselx == 2)
	pready <=  penable;
      else if(pselx == 3)
	pready <=  penable;
      else
	pready <= 0;
      end // else: !if(!presetn)
   end

   //assign pready = (pselx == 0) ? 1'd1 : (pselx == 1) ? (pselx[0] & penable) : (pselx[2]) ? (pselx[1] & penable) : 0;
   
   
   //assign pready = (pselx[1] && penable); 
   
   // register map for write
   always @(posedge pclk) begin
      if(!presetn) begin
	 din      <= 0;
	 tx_start <= 0;
	 dvsr     <= 0;
      end else begin
	 if(pwrite && pselx == 3) begin
	    case(paddr[7:0])
	      `TX_DIN   : din      <= pwdata[7:0];
	      `TX_START : tx_start <= pwdata[0];
	      `DVSR     : dvsr     <= pwdata[10:0];
	    endcase // case (paddr[7:0])
	 end
      end // else: !if(!presetn)
   end // always_ff @ (posedge pclk)

   // register map for read
   always_comb begin
      if(!pwrite && pselx == 3) begin
	 case(paddr[7:0])
	   `TX_BUSY : prdata = {31'h0, tx_busy};
	   `RX_DOUT : prdata = {24'h0, dout};
	   `RX_BUSY : prdata = {31'h0, rx_busy};
	   default  : prdata = 32'h0;
	 endcase // case (paddr[7:0])
      end
   end
   
   
endmodule // apb_ctrl
// Local Variables: 
// Verilog-Library-Directories:("~/Projects/FPGA_Projects/iVerilog/design/apb/" ".") 
// End:
