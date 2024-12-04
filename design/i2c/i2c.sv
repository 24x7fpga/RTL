`timescale 1ns/1ns 
module i2c(/*AUTOARG*/
   // Outputs
   o_scl,
   // Inouts
   o_sda,
   // Inputs
   i_clk, i_rst, i_wrt, i_data
   );
   // Outputs
   inout  tri1 o_sda;
   output tri1 o_scl;
   // Inputs
   input       i_clk; 
   input       i_rst;
   input       i_wrt;
   input [7:0] i_data;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/
      
   i2c_master MTR (/*AUTOINST*/
		   // Outputs
		   .o_scl		(o_scl),
		   // Inouts
		   .o_sda		(o_sda),
		   // Inputs
		   .i_clk		(i_clk),
		   .i_rst		(i_rst),
		   .i_wrt		(i_wrt),
		   .i_data		(i_data[7:0])); 
 
endmodule 
// Local Variables: 
// Verilog-Library-Directories:("~/Projects/FPGA_Projects/iVerilog/design/i2c/" ".") 
// End:

