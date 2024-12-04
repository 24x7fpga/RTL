/////////////////////////////////////////////////////////////////////
// Reference: FPGA Prototyping using SV Examples by Pong P. Chu
////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns
`include "parameters.v" 
module fifo_buffer_ctrl(/*AUTOARG*/
   // Outputs
   full, empty, al_full, al_empty, wr_en, rd_en, rd_addr, wr_addr,
   wr_data, wd_cnt,
   // Inputs
   clk, rst, wr, rd, data
   ); 
   input clk; 
   input rst;
   input wr;
   input rd;
   input [`DATA_WIDTH-1:0] data;
   
   // status flags
   output 		     full;
   output 		     empty;
   output 		     al_full;
   output 		     al_empty;
   output 		     wr_en;
   output 		     rd_en;
   output [`ADDR_WIDTH-1:0]  rd_addr;
   output [`ADDR_WIDTH-1:0]  wr_addr;
   output [`DATA_WIDTH-1:0]  wr_data;
   output [`ADDR_WIDTH-1:0]  wd_cnt;

   /*AUTOREG*/

   /*AUTOWIRE*/

   reg [`ADDR_WIDTH-1:0] wr_ptr_reg, wr_ptr_nxt, wr_ptr_succ;
   reg [`ADDR_WIDTH-1:0] rd_ptr_reg, rd_ptr_nxt, rd_ptr_succ;
   reg 			 empty_reg, empty_nxt;
   reg 			 full_reg, full_nxt;
   reg [`ADDR_WIDTH-1:0] wd_ctr_reg, wd_ctr_nxt;
   

   // synchronous write and read pointers
   always@(posedge clk)
     begin
	if(!rst)begin
	   wr_ptr_reg <= 'h0;
	   rd_ptr_reg <= 'h0;
	   empty_reg  <= 'h1;
	   full_reg   <= 'h0;
	   wd_ctr_reg <= 'h0;
	end else begin
	   wr_ptr_reg <= wr_ptr_nxt;
	   rd_ptr_reg <= rd_ptr_nxt;
	   empty_reg  <= empty_nxt;
	   full_reg   <= full_nxt;
	   wd_ctr_reg <= wd_ctr_nxt;
	end // else: !if(!rst)
     end // always@ (posedge clk)

   always@(/*AUTOSENSE*/empty_reg or full_reg or rd or rd_ptr_reg
	   or wd_ctr_reg or wr or wr_ptr_reg)
     begin
	// default conditions
	wr_ptr_nxt = wr_ptr_reg;
	rd_ptr_nxt = rd_ptr_reg;
	empty_nxt  = empty_reg;
	full_nxt   = full_reg;
	wd_ctr_nxt = wd_ctr_reg;

	// successive pointers
	wr_ptr_succ = wr_ptr_reg + 'h1;
	rd_ptr_succ = rd_ptr_reg + 'h1;

	case({wr,rd})
	  2'b01 : begin // read
	     if(!empty_reg)begin
		rd_ptr_nxt = rd_ptr_reg + 'h1;
		full_nxt   = 'h0;
		wd_ctr_nxt = wd_ctr_reg - 'h1;
		if(rd_ptr_succ == wr_ptr_reg)begin
		  empty_nxt = 'h1;
		  wd_ctr_nxt = wd_ctr_reg;
		end
	     end
	  end
	  
	  2'b10 : begin // write
	     if(!full_reg)begin
		wr_ptr_nxt = wr_ptr_reg + 'h1;
		empty_nxt  = 'h0;
		wd_ctr_nxt = wd_ctr_reg + 'h1;
		if(wr_ptr_succ == rd_ptr_reg)begin
		  full_nxt = 'h1;
		  wd_ctr_nxt = wd_ctr_reg;
		end
	     end
	  end

	  2'b11 : begin // read and write
	     wr_ptr_nxt = wr_ptr_succ;
	     rd_ptr_nxt = rd_ptr_succ;
	  end
	endcase // case ({wr,rd})

     end // always@ (...
  
   // outputs
   assign wr_addr  = wr_ptr_reg;
   assign rd_addr  = rd_ptr_reg;
   assign wr_data  = data;
   assign wr_en    = (wr && !full_reg);
   assign rd_en    = (rd && !empty_reg);
   assign full     = full_reg;
   assign al_full  = (wd_ctr_reg >= `ALMOST_FULL);
   assign empty    = empty_reg;
   assign al_empty = (wd_ctr_reg <= `ALMOST_EMPTY);
   assign wd_cnt   = wd_ctr_reg;
   
	     
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End: 
