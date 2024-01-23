`timescale 1ns/1ns
module freq_div #(parameter n = 4) (/*AUTOARG*/
   // Outputs
   div3, div5, div7,
   // Inputs
   clk, rst
   );
   input clk;
   input rst;

   output div3;
   output div5;
   output div7;

   freq_div_odd #(/*AUTOINSTPARAM*/
		 // Parameters
		 .n			(n)) ODD_DIV (/*AUTOINST*/
						     // Outputs
						     .div3		(div3),
						     .div5		(div5),
						     .div7		(div7),
						     // Inputs
						     .clk		(clk),
						     .rst		(rst));
   
endmodule
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
