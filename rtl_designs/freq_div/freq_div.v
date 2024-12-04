`timescale 1ns/1ns
module freq_div #(parameter n = 4) (/*AUTOARG*/
   // Outputs
   div2, div4, div6, div3, div5, div7,
   // Inputs
   clk, rst
   );
   input clk;
   input rst;

   // even dividers
   output div2;
   output div4;
   output div6;
 
   // odd  dividers
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

   freq_div_even #(/*AUTOINSTPARAM*/
		   // Parameters
		   .n			(n)) EVEN_DIV (/*AUTOINST*/
						       // Outputs
						       .div2		(div2),
						       .div4		(div4),
						       .div6		(div6),
						       // Inputs
						       .clk		(clk),
						       .rst		(rst));
   
   
endmodule
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
