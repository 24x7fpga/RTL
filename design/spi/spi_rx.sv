`timescale 1ns/1ns
module spi_rx #(parameter mode = 0, width = 8) (/*AUTOARG*/
   // Outputs
   miso, rx_dout,
   // Inputs
   mosi, sclk, cs, rst, clk
   );
   // outputs
   output miso;
   output [width-1:0] rx_dout;

   //input
   input	      mosi;
   input	      sclk;
   input	      cs;
   input	      rst;
   input	      clk;
   

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			miso;
   // End of automatics
   /*AUTOWIRE*/
   
   // fsm states
   typedef enum {idle, sample} state_type;

   state_type st_reg, st_nxt;

   logic [width-1:0]	  cnt_reg, cnt_nxt;
   logic [width-1:0]	  din_reg, din_nxt;
  
  generate
     if(mode == 0 || mode == 3)begin	
        always_ff@(posedge sclk, posedge rst)
          if(rst)begin
             st_reg <= idle;
             cnt_reg <= 0;
             din_reg <= 0;
          end else begin
             st_reg <= st_nxt;
             cnt_reg  <= cnt_nxt;
             if(~cs)begin
                din_reg <= {din_reg[width-2:0],mosi};
                miso <= din_reg[width-1];
             end
          end
     end
     
     if(mode == 1 || mode == 2)begin	
        always_ff@(negedge sclk, posedge rst)
          if(rst)begin
             st_reg <= idle;
             cnt_reg  <= 0;
             din_reg <= 0;
          end else begin
             st_reg <= st_nxt;
             cnt_reg  <= cnt_nxt;
             if(~cs)begin
                din_reg <= {din_reg[width-2:0],mosi};
                miso <= din_reg[width-1];
             end
          end
     end
   endgenerate
   

   always_comb begin
      st_nxt = st_reg;
      din_nxt=din_reg;
      cnt_nxt=cnt_reg;
      
      case (st_reg)
      
      idle: begin
            if(~cs)
                st_nxt = sample;
            end

      sample: begin                 
            if(cnt_reg == width-1)
                cnt_nxt = 0;
            else
                cnt_nxt = cnt_reg + 1;
            end

    endcase

end

   assign rx_dout = (cnt_reg == width-1) ? din_reg : 'h0;

endmodule
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/spi" ".")
// End:
