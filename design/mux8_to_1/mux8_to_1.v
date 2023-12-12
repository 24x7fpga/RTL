`timescale 1ns/1ns

module mux8_to_1(/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   din, sel
   );
   input [7:0] din;
   input [2:0] sel;
   output  z;
   
/*AUTOREG*/ 
/*AUTOWIRE*/

   wire        temp1, temp2;
   
 
   mux4_to_1 m1 (/*AUTOINST*/
		 // Outputs
		 .z			(temp1),
		 // Inputs
		 .din			(din[3:0]),
		 .sel			(sel[1:0]));
   mux4_to_1 m2 (/*AUTOINST*/
		 // Outputs
		 .z			(temp2),
		 // Inputs
		 .din			(din[7:4]),
		 .sel			(sel[1:0]));

   assign z = sel[2] ? temp2 : temp1;
   
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/mux4_to_1/" ".") 
// End:
