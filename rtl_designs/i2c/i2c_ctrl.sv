`include "package.svh"
module i2c_ctrl (/*AUTOARG*/
   // Outputs
   sda_en, tx_data, start, o_data, rw, rx_ack,
   // Inputs
   clk, rst_n, init, busy, done, rd_wr, addr, cmd, data, rx_data, wr
   );
   // Outputs
   output        sda_en;
   output [7:0]	 tx_data;
   output	 start;
   output [15:0] o_data;
//   output	 i_sda;
   output	 rw;
   output	 rx_ack;
   // Inputs
   input	 clk;
   input	 rst_n;
   input	 init;
   input	 busy;
   input	 done;
   input	 rd_wr;
   input [6:0]	 addr;
   input [7:0]	 cmd;
   input [7:0]	 data;
   input [7:0]	 rx_data;
   input wr;
  
  logic [15:0] o_data_reg, o_data_nxt;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
//   reg			i_sda;
   reg [15:0]		o_data;
   reg			rw;
   reg			rx_ack;
   reg			sda_en;
   reg			start;
   reg [7:0]		tx_data;
   // End of automatics
   /*AUTOWIRE*/

  
   // FSM State
   typedef enum {st_idle, st_addr, st_addr_ack, st_cmd, st_cmd_ack, st_data, st_data_ack, st_recv, st_ack, st_recv2, st_nack} state_type;
   state_type st_reg, st_nxt;

   always_ff@(posedge clk)begin
     if(!rst_n)begin
	st_reg <= st_idle;
	o_data_reg <= 16'h0;
     end else begin
	st_reg <= st_nxt;
	o_data_reg <= o_data_nxt;
     end
   end

   always_comb begin
      st_nxt = st_reg;
      // Flags signals
      start  = 1'b0;
      rw     = 1'b0;
      sda_en = 1'b0;
      rx_ack = 1'bz;
      tx_data= 8'h0;
      o_data_nxt=o_data_reg;

      case(st_reg)
	st_idle : begin
	   if(init) begin
	      st_nxt = st_addr;
	      start  = 1'b1;
	   end else begin
	      st_nxt = st_idle;
	      start = 1'b0;
	   end
	end

	st_addr : begin
	   rw      = 1'b0;
	   tx_data = {addr, rd_wr};
	   if(busy)
	     st_nxt = st_addr;
	   else
	     st_nxt = st_addr_ack;
	end

	st_addr_ack : begin
	   start = 1'b1;
	   if(rd_wr)
	       rw      = 1'b1;
	   else
	       rw      = 1'b0;
	       
	   if(busy)begin
	      if(rd_wr)begin
            st_nxt = st_recv;
	      end else begin
            st_nxt = st_cmd;
          end
	   end else
	     st_nxt = st_addr_ack;
	end

	st_cmd : begin
	   rw      = 1'b0;
	   tx_data = cmd;
	   if(busy)
	     st_nxt = st_cmd;
	   else
	     st_nxt = st_cmd_ack;
	end

	st_cmd_ack : begin
	   if(wr)begin
	       start = 1'b1;
	       if(busy)
	           st_nxt = st_data;
	       else
	           st_nxt = st_cmd_ack;
	   end else begin
	       start = 1'b0;
	       if(done)
	       st_nxt = st_idle;
	       else
	       st_nxt = st_cmd_ack;
	   end	  
	end

	st_data : begin
	   rw      = 1'b0; 
	   tx_data = data;
	   if(busy)
	     st_nxt = st_data;
	   else
	     st_nxt = st_data_ack;
	end

	st_data_ack : begin
	   if(done)
	     st_nxt = st_idle;
	   else
	     st_nxt = st_data_ack;
	end

	st_recv : begin   
	   if(busy)
	     st_nxt = st_recv;
	   else begin
	     o_data_nxt[15:8] = rx_data;
	     case(cmd[1:0])
	       2'b00 , 2'b11: st_nxt = st_ack;
	       default : st_nxt = st_nack;
	     endcase // case (data[1:0])
	   end
	end // case: st_recv

	st_ack : begin
	   sda_en = 1'b1;
	   start  = 1'b1;
	   rx_ack = 1'b0;
	   if(busy)
	     st_nxt = st_recv2;
	   else
	     st_nxt = st_ack;
	end

	st_recv2 : begin
	   if(busy)
	     st_nxt = st_recv2;
	   else begin
	      o_data_nxt[7:0] = rx_data;
	      st_nxt = st_nack;
	   end
	end

	st_nack : begin
	   sda_en = 1'b1;
	   rx_ack = 1'b1;
	   if(done)
	     st_nxt = st_idle;
	   else
	     st_nxt = st_nack;
	end

      endcase // case (st_reg)
   end // always_comb

assign o_data = o_data_reg;

endmodule // i2c_ctrl
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
