`timescale 1ns/1ns
module i2c_clk(/*AUTOARG*/
   // Outputs
   i_clk,
   // Inputs
   m_clk, m_rst
   );
   // Outputs
   output i_clk;
   // Inputs
   input  m_clk;
   input  m_rst;

   /*AUTOREG*/
   /*AUTOWIRE*/
   
   localparam dvsr = 1250; // 125M/100k = 1250

   logic [10:0] cnt;
   
   always_ff@(posedge m_clk) begin
      if(m_rst)
	cnt <= 11'h0;
      else
	cnt <= (cnt == dvsr) ? 11'h0 : cnt + 11'h1;
   end

   assign i_clk = cnt < dvsr/2 ? 1'b0 : 1'b1;

endmodule // i2c_clk
// Local Variables: 
// Verilog-Library-Directories:("~/Projects/FPGA_Projects/iVerilog/design/i2c/" ".") 
// End:
 
      
   

