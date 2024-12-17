`timescale 1ns/1ns
module uart_tx #(parameter DBIT = 8, SB_TICK = 16)(/*AUTOARG*/
   // Outputs
   tx_done_tick, tx,
   // Inputs
   clk, rst, din, tx_start, s_tick
   );
   input logic clk;
   input logic rst;
   input logic [7:0] din;
   input logic 	     tx_start;
   input logic 	     s_tick;
   output logic      tx_done_tick;
   output logic      tx;

   // fsm states
   typedef enum      {idle, start, data, stop} state_type;

   state_type st_reg, st_nxt;

   logic [3:0] 	tk_reg, tk_nxt;
   logic [2:0] 	bt_reg, bt_nxt;
   logic [7:0] 	dt_reg, dt_nxt;
   logic 	tx_reg, tx_nxt;
   
   always_ff@(posedge clk, posedge rst)
     if(rst)begin
	st_reg <= idle;
	tk_reg <= 0;
	bt_reg <= 0;
	dt_reg <= 0;
	tx_reg <= 0;
     end else begin
	st_reg <= st_nxt;
	tk_reg <= tk_nxt;
	bt_reg <= bt_nxt;
	dt_reg <= dt_nxt;
	tx_reg <= tx_nxt;
     end // else: !if(rst)

   always_comb begin
      st_nxt = st_reg;
      tk_nxt = tk_reg;
      bt_nxt = bt_reg;
      dt_nxt = dt_reg;
      tx_nxt = tx_reg;
      tx_done_tick = 1'b0;

      case(st_reg)

	idle: begin
	  tx_nxt = 1'b1;
	  if(tx_start)begin
	     st_nxt = start;
	     tk_nxt = 0;
	     dt_nxt = din;
	  end
	end // case: begin

	start: begin
	   tx_nxt = 1'b0;
	   if(s_tick)
	     if(tk_reg == 15)begin
		st_nxt = data;
		tk_nxt = 0;
		bt_nxt = 0;
	     end
	     else
	       tk_nxt = tk_reg + 1;
	end // case: start

	data: begin
	   tx_nxt = dt_reg[0];
	   if(s_tick)
	     if(tk_reg == 15)begin
		tk_nxt = 0;
		dt_nxt = dt_reg >> 1;
		if(bt_nxt == (DBIT-1))
		  st_nxt = stop;
		else
		  bt_nxt = bt_reg + 1;
	     end
	     else
	       tk_nxt = tk_reg + 1;
	end // case: data

	stop: begin
	   tx_nxt =  1'b1;
	   if(s_tick)
	     if(tk_reg == (SB_TICK-1))begin
		st_nxt = idle;
		tx_done_tick = 1'b1;
	     end
	     else
	       tk_nxt = tk_reg +1;
	end // case: stop
	
      endcase // case (st_reg)
   end // always_comb
   
   assign tx = tx_reg;
	
endmodule // uart_tx
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
