`timescale 1ns/1ns
module spi_tx #(parameter mode = 0, dvsr = 31, width = 8) (/*AUTOARG*/
   // Outputs
   mosi, sclk, cs, tx_dout, tx_rdy, rx_vld,
   // Inputs
   miso, tx_vld, din, rst, clk
   );
   //outputs
   output mosi;
   output sclk;
   output cs;
   output [width-1: 0] tx_dout;
   output	       tx_rdy;
   output	       rx_vld;
   
   //input
   input	       miso;
   input	       tx_vld;
   input [width-1: 0] din;
   input	       rst;
   input	       clk;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			rx_vld;
   reg			tx_rdy;
   // End of automatics
   /*AUTOWIRE*/

   
   // fsm states
   typedef enum {idle, drive, sample} state_type;

   state_type st_reg, st_nxt;

   logic [$clog2(dvsr): 0] dvsr_reg, dvsr_nxt;
   logic [width-1: 0]	   cnt_reg, cnt_nxt;
   logic		   cpol, cpha;
   logic		   temp_clk, sclk_reg, sclk_nxt;
   logic		   cs_reg, cs_nxt;
   logic [width-1:0]	   mosi_reg, mosi_nxt;
   logic [width-1:0]	   miso_reg, miso_nxt;
   
   
   
   

   // spi mode decoder
   always_comb begin
      case(mode)
	'h0 : begin
	   cpol = 0;
	   cpha = 0;
	end
	
	'h1 : begin
	   cpol = 0;
	   cpha = 1;
	end

	'h2 : begin
	   cpol = 1;
	   cpha = 0;
	end

	'h3 : begin
	   cpol = 1;
	   cpha = 1;
	end
      endcase // case (mode)
   end // always_comb
   
      

   always_ff@(posedge clk)
     if(rst)begin
	st_reg   <= idle;
	cnt_reg  <= 0;
	dvsr_reg <= 0;
	sclk_reg <= 0;
	mosi_reg <= 0;
	miso_reg <= 0;
	cs_reg   <= 1;
     end else begin
	st_reg   <= st_nxt;
	cnt_reg  <= cnt_nxt;
	dvsr_reg <= dvsr_nxt;
	sclk_reg <= sclk_nxt;
	mosi_reg <= mosi_nxt;
	miso_reg <= miso_nxt;
	cs_reg   <= cs_nxt;
     end

   always_comb begin
      st_nxt   = st_reg;
      cnt_nxt  = cnt_reg;
      dvsr_nxt = dvsr_reg;
      mosi_nxt = mosi_reg;
      cs_nxt   = cs_reg;
      
      rx_vld   = 0;

      case(st_reg)

	idle: begin
	   if(tx_vld)begin
	      cs_nxt = 0;
	      dvsr_nxt = dvsr_reg + 1;
	      if(dvsr_reg == dvsr)begin
		      st_nxt = drive;
		      dvsr_nxt = 0;
	      end
	   end
	end

	drive: begin
	   mosi_nxt = din << cnt_reg;
	   dvsr_nxt = dvsr_reg + 1;
	   if(dvsr_reg == dvsr)begin
	      st_nxt = sample;
	      dvsr_nxt = 0;
	   end
	end

	sample: begin
	   // read miso
	   miso_nxt[width-1-cnt_reg] = miso;
	   
	   dvsr_nxt = dvsr_reg + 1;
	   if(dvsr_reg == dvsr)begin
	      cnt_nxt = cnt_reg + 1;
	      dvsr_nxt = 0;
	      
	      if(cnt_reg == width-1) begin
		      cnt_nxt = 0;
		      rx_vld  = 1;
		      if(~tx_vld)
		          st_nxt  = idle;
		  end 
		      st_nxt = drive;
		  end
	end

      endcase // case (st_reg)
   end // always_comb

   // look-ahead decoder
   assign temp_clk = (st_nxt == drive && cpha) || (st_nxt == sample && ~cpha);

   // spi clk
   assign sclk_nxt = (cpol) ? ~temp_clk : temp_clk;

   // registered data
   assign cs   = cs_reg;
   assign sclk = sclk_reg;
   assign mosi = mosi_reg[width-1];
   assign tx_dout = miso_reg;
   
   
endmodule // spi_tx 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
