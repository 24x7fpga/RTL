`include "package.svh"
module i2c_master (/*AUTOARG*/
   // Outputs
   o_sda, o_scl, busy, done, rx_data,
   // Inputs
   clk, rst_n, rw, start, i_sda, rx_ack, tx_data
   );
   // Outputs
   output   o_sda;
   output	o_scl;
   output	busy;
   output	done;
   output [7:0]	rx_data;
   // Inputs
   input	clk;
   input	rst_n;
   input	rw;
   input	start;
   input	i_sda;
   input	rx_ack;
   input [7:0]	tx_data;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			busy;
   reg			done;
   reg			o_scl;
   reg			o_sda;
   reg [7:0]		rx_data;
   // End of automatics
   /*AUTOWIRE*/

   
   logic [1:0]	ph;                    // phase
   logic [11:0]	dvsr_cnt;              // dvst counter
   logic [11:0]	quand;

   logic [2:0]	cnt_reg, cnt_nxt;
   logic	ack_reg,ack_nxt;
   
   logic [7:0] tx_reg, tx_nxt;
   logic [7:0] rx_reg, rx_nxt;
 

   // FSM States
   typedef enum {st_idle, st_start, st_tx_data, st_tx_ack, st_rx_data, st_rx_ack, st_end, st_stop} state_type;
   state_type st_reg, st_nxt;
   
   assign quand = `DVSR >> 2;             // quarter scl period
   
   // Phase Generation
   always_ff@(posedge clk)begin
      if(!rst_n)begin
	 dvsr_cnt <= 12'h0;
      end else begin
	 if(st_reg != st_idle)begin
	   if(dvsr_cnt == `DVSR-1)
	       dvsr_cnt <= 12'h0;
	   else
	       dvsr_cnt <= dvsr_cnt + 1;
	 end else
	   dvsr_cnt <= 12'h0;
      end
   end

   always_comb begin
      if(dvsr_cnt < quand)
	ph = 2'b00;
      else if(dvsr_cnt < 2*quand)
	ph = 2'b01;
      else if(dvsr_cnt < 3*quand)
	ph = 2'b10;
      else
	ph = 2'b11;
   end

   //
   always_ff@(posedge clk)begin
      if(!rst_n)begin
	 st_reg  <= st_idle;
	 cnt_reg <= 3'h7;
	 ack_reg <= 1'b0;
	 tx_reg  <= 8'h0;
	 rx_reg  <= 8'h0;
      end else begin
	 st_reg  <= st_nxt;
	 cnt_reg <= cnt_nxt;
	 ack_reg <= ack_nxt;
	 tx_reg  <= tx_data;
	 rx_reg  <= rx_nxt;
      end
   end

   always_comb begin
      // Default SDA, SCL signals
      o_sda   = 1'b1;
      o_scl   = 1'b1;
      // States
      st_nxt  = st_reg;
      // Flags
      busy    = 1'b0;
      done    = 1'b0;
      ack_nxt = 1'b0;
      // Date count
      cnt_nxt = 3'h7;
//      tx_nxt = tx_reg;
      rx_nxt = rx_reg;
      
      case(st_reg)
	st_idle : begin
	   if(start)
	     st_nxt = st_start;
	   else
	     st_nxt = st_idle;
	end

	st_start : begin
	   o_scl = !ph[1];
	   busy  = 1'b1;
	   if(dvsr_cnt > quand)
	     o_sda = 1'b0;

	   if(dvsr_cnt == `DVSR-1)begin
		st_nxt = st_tx_data;
	   end else begin
	      st_nxt   = st_start;
	   end
	end // case: st_start

	st_tx_data : begin
	   o_scl = ph[1] ^ ph[0];
	   o_sda = tx_reg[cnt_reg];
	   busy  = 1'b1;
	   // Update counter
	   if(cnt_reg == 0 && dvsr_cnt == `DVSR-1)
	     st_nxt  = st_tx_ack;
	   else begin
	      st_nxt = st_tx_data;
	      if(dvsr_cnt == `DVSR-1)
		cnt_nxt = cnt_reg - 1;
	      else
		cnt_nxt = cnt_reg;
	   end
	end // case: st_tx_data

	st_tx_ack : begin
	   o_scl = ph[1] ^ ph[0];
	   busy  = 1'b0;
	   if((ph[1] & ~ph[0]) & !i_sda)
	      ack_nxt = 1'b1;
	   else
	     ack_nxt  = ack_reg;

	   if((dvsr_cnt == `DVSR-1) & ack_reg)
	     if(start)begin
	       if(rw)
		    st_nxt = st_rx_data;
	      else
	       st_nxt = st_tx_data;
	     end else
	       st_nxt = st_end;
	   else
	     st_nxt = st_tx_ack;
	end // case: st_tx_ack

	st_rx_data : begin
	   o_scl = ph[1] ^ ph[0];
	   busy  = 1'b1;
	   // receive data
	   rx_nxt[cnt_reg] = i_sda;
	   // update counter
	   if(cnt_reg == 0 && dvsr_cnt == `DVSR-1)
	     st_nxt  = st_rx_ack;
	   else begin
	      st_nxt = st_rx_data;
	      if(dvsr_cnt == `DVSR-1)
		cnt_nxt = cnt_reg - 1;
	      else
		cnt_nxt = cnt_reg;
	   end
	end // case: st_rx_data

	st_rx_ack : begin
	   o_scl = ph[1] ^ ph[0];
	   o_sda = rx_ack;

	   if(dvsr_cnt == `DVSR-1)begin
	     if(start)
	       st_nxt = st_rx_data;
	     else
	       st_nxt = st_end;
	   end else
	     st_nxt = st_rx_ack;
	end // case: st_rx_ack

	st_end : begin
	   o_scl = 1'b0;
	   o_sda = 1'b0;
	   // done flag
	   done  = 1'b1;
	
	   if(dvsr_cnt > quand)
	     st_nxt = st_stop;
	   else
	     st_nxt = st_end;
	end // case: st_end

	st_stop : begin
	   o_scl = 1'b1;
	   
	   if(dvsr_cnt > 2*quand)
	     o_sda = 1'b1;
	   else
	     o_sda = 1'b0;

	   if(dvsr_cnt == `DVSR-1)
	     st_nxt = st_idle;
	   else
	     st_nxt = st_stop;
	end // case: st_stop

      endcase // case (st_reg)
   end // always_comb
	   
assign rx_data = rx_reg;

endmodule // i2c_master
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
 
   
 
