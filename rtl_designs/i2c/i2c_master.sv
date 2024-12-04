`timescale 1ns/1ns
module i2c_master(/*AUTOARG*/
   // Outputs
   o_scl,
   // Inouts
   o_sda,
   // Inputs
   i_clk, i_rst, i_wrt, i_data
   );
   // Outputs
   inout  tri1  o_sda;
   output tri1	o_scl;
   // Inputs
   input	i_clk;
   input	i_rst;
   input	i_wrt;
   input [7:0]	i_data;

   /*AUTORE*/
   /*AUTOWIRE*/
   
   localparam	dvsr = 624; // 1250-1
   logic [10:0]	dvsr_reg, dvsr_nxt;

   logic [7:0]	data_reg, data_nxt;
   logic [7:0]	sda_in_reg, sda_in_nxt;
   
   logic [3:0]	cnt_reg, cnt_nxt;
   
   logic	sda, scl, sda_in;

   logic	wr_reg, wr_nxt;
   
   // FSM States
   typedef enum {idle, start1, start2, check, data1, data2, data3, data4, data_end, stop1, stop2} state_type;
   state_type st_reg, st_nxt;

   always_ff@(posedge i_clk)begin
      if(i_rst)begin
	 st_reg   <= idle;
	 dvsr_reg <= 0;
	 data_reg <= 0;
	 cnt_reg  <= 0;
      end else begin
	 st_reg   <= st_nxt;
	 dvsr_reg <= dvsr_nxt;
	 data_reg <= data_nxt;
	 cnt_reg  <= cnt_nxt;
      end
   end

   always_comb begin
      st_nxt   = st_reg;
      dvsr_nxt = ((st_reg == idle) || (dvsr_reg == dvsr)) ? 0 : dvsr_reg + 1;
      wr_nxt   = wr_reg;
      data_nxt = data_reg;
      cnt_nxt  = cnt_reg;
      
      case(st_reg)
	idle : begin
	   sda      = 1'b1;
	   scl      = 1'b1;
	   dvsr_nxt = 11'h0;
	   data_nxt = i_data;
	   if(i_wrt)
	     st_nxt = start1;
	   else
	     st_nxt = idle;
	end

	start1 : begin
	   sda      = 1'b0;
	   scl      = 1'b1;
	   if(dvsr_reg == dvsr)
	     st_nxt = start2;
	   else
	     st_nxt = start1;
	end

	start2 : begin
	   sda      = 1'b0;
	   scl      = 1'b0;
	   if(dvsr_reg == dvsr)
	     st_nxt = check;
	   else
	     st_nxt = start2;
	end

	check : begin
	   sda      = 1'b0;
	   scl      = 1'b0;
	   wr_nxt   = i_data[0];
	   cnt_nxt  = 0;
	   st_nxt   = data1;
	end

	data1 : begin
	   sda      = data_reg[7];
	   scl      = 1'b0;
	   if(dvsr_reg > dvsr/2) begin
	      st_nxt = data2;
	      sda_in = o_sda;
	   end else begin
	      st_nxt = data1;
	   end
	end

	data2 : begin
	   sda      = data_reg[7];
	   scl      = 1'b1;
	   if(dvsr_reg == dvsr) begin
	      st_nxt = data3;
	      sda_in_nxt = sda_in_reg << o_sda;
	   end else begin
	      st_nxt = data2;
	   end
	end

	data3 : begin
	   sda       = data_reg[7];
	   scl       = 1'b1;
	   if(dvsr_reg > dvsr/2) begin
	      st_nxt = data4;
	   end else begin
	      st_nxt = data3;
	   end
	end

	data4 : begin
	   sda       = data_reg[7];
	   scl       = 1'b0;
	   if(dvsr_reg == dvsr) begin
	      if(cnt_reg == 8) begin
		 st_nxt   = data_end;
		 cnt_nxt  = 0;
	      end else begin
		 st_nxt   = data1;
		 data_nxt = data_reg << 1;
		 cnt_nxt  = cnt_reg + 1;
	      end
	   end
	end // case: data4

	data_end : begin
	   sda      = 1'b0;  
	   scl      = 1'b0;
	   if(dvsr_reg == dvsr/2)
	     st_nxt = stop1;
	   else
	     st_nxt = data_end;
	end
	
	stop1 : begin
	   sda      = 1'b0;
	   scl      = 1'b1;
	   if(dvsr_reg == dvsr)
	     st_nxt = stop2;
	   else
	     st_nxt = stop1;
	end

	stop2 : begin
	   sda      = 1'b1;
	   scl      = 1'b1;
	   if(dvsr_reg == dvsr/2)
	     st_nxt = idle;
	   else
	     st_nxt = stop2;
	end

      endcase // case (st_reg)   
   end // always_comb
   
   assign o_sda = (sda && cnt_reg < 8) ? 1'bz : sda; 
   assign o_scl = (scl) ? 1'bz : scl;
   
endmodule // i2c_master
// Local Variables: 
// Verilog-Library-Directories:("~/Projects/FPGA_Projects/iVerilog/design/i2c/" ".") 
// End:
