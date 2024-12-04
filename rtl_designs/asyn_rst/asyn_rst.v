`timescale 1ns/1ns 
module asyn_rst(/*AUTOARG*/
   // Outputs
   rst_main,
   // Inputs
   clk, rst_asyn
   ); 
  input clk; 
  input rst_asyn;
  output  rst_main; 
 
  /*AUTOREG*/ 
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg			rst_main;
  // End of automatics
  /*AUTOWIRE*/ 
  
  reg temp_rst;

  always@(posedge clk, negedge rst_asyn)
    begin
	if(!rst_asyn)
		{rst_main, temp_rst} <= 2'b00;
	else
		{rst_main, temp_rst} <= {temp_rst, 1'b1};
    end
 

endmodule 
// Local Variables: 
//verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
