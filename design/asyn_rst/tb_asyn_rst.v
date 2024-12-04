`timescale 1ns/1ns 
module tb_asyn_rst(); 
localparam t = 10; 
reg clk; 
reg rst_asyn; 
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			rst_main;		// From DUT of asyn_rst.v
// End of automatics
asyn_rst DUT (/*AUTOINST*/
	      // Outputs
	      .rst_main			(rst_main),
	      // Inputs
	      .clk			(clk),
	      .rst_asyn			(rst_asyn)); 

   initial clk = 1; 
   always #(t/2) clk = ~clk; 

   initial begin
      rst_asyn = 0;
      #(7)
      rst_asyn = 1; 
      #(21); 
      rst_asyn = 0;
      #(16);
      rst_asyn = 1;
      #(24)
      rst_asyn = 0;
      #(27)
      rst_asyn = 1;
      #(21)
      rst_asyn = 0;
      #(10)
      $finish;
   end
 
   initial begin 
      $dumpfile("tb_asyn_rst.vcd"); 
      $dumpvars(0,tb_asyn_rst); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/asyn_rst" ".")
// End:
