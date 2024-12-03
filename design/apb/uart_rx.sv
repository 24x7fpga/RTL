`timescale 1ns/1ns
module uart_rx #(parameter DBIT = 8, SB_TICK = 16)(/*AUTOARG*/
   // Outputs
   dout, rx_busy, rx_done_tick,
   // Inputs
   clk, rst, rx, s_tick
   );
   input logic clk;
   input logic rst;
   input logic rx;
   input logic s_tick;

   output logic [7:0] dout;
   output logic	      rx_busy;
   output logic	rx_done_tick;

   // fsm states
   typedef enum {idle, start, data, stop} state_type;

   state_type st_reg, st_nxt;

   logic [3:0] 	tk_reg, tk_nxt;    // tick counter
   logic [2:0] 	bt_reg, bt_nxt;    // bit position counter
   logic [7:0] 	dt_reg, dt_nxt;    // data registers


   always_ff@(posedge clk, posedge rst)
     if(rst)begin
	st_reg <= idle;
	tk_reg <= 0;
	bt_reg <= 0;
	dt_reg <= 0;
     end else begin
	st_reg <= st_nxt;
	tk_reg <= tk_nxt;
	bt_reg <= bt_nxt;
	dt_reg <= dt_nxt;
     end // else: !if(rst)

   always_comb begin
      st_nxt = st_reg;
      tk_nxt = tk_reg;
      bt_nxt = bt_reg;
      dt_nxt = dt_reg;
      rx_done_tick = 1'b0;
      case(st_reg)
	
	idle: begin
	  if(~rx)begin
	    st_nxt = start;
	     tk_nxt = 0;
	  end
	end // case: idle
      
  
	start: begin
	  if(s_tick)
	    if(tk_reg == 7)begin
	       st_nxt = data;
	       tk_nxt = 0;
	       bt_nxt = 0;
	    end
	    else
	      tk_nxt = tk_reg + 1;
	end // case: start
	

	data: begin
	  if(s_tick)
	    if(tk_reg == 15)begin
	       tk_nxt = 0;
	       dt_nxt = {rx, dt_reg[7:1]};
	       if(bt_nxt == (DBIT-1))
		 st_nxt = stop;
	       else
		 bt_nxt = bt_reg + 1;
	    end
	    else
	      tk_nxt = tk_reg + 1;
	end // case: data
	

	stop: begin
	  if(s_tick)
	    if(tk_reg == (SB_TICK - 1))begin
	       st_nxt = idle;
	       rx_done_tick = 1'b1;
	    end
	    else
	      tk_nxt = tk_reg + 1;
	end // case: stop
	

      endcase // case (st_reg)
   end // always_comb

   // assign busy
   assign rx_busy = (st_reg == idle) ? 1'b0 : 1'b1;
   
   assign dout = dt_reg;

endmodule // uart_rx
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*" ".") 
// End:
	
	       
	       
	
	
	       
	
	
   
