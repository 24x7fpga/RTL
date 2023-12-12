`timescale 1ns/1ns

module mux4_to_1(/*autoarg*/
   // Outputs
   z,
   // Inputs
   din, sel
   );
   input [3:0] din;
   input [1:0] sel;
   output  reg   z;

   always@(*)
     begin
	case(sel)
	  2'h0 : z = din[0];
	  2'h1 : z = din[1];
	  2'h2 : z = din[2];
	  2'h3 : z = din[3];
	  default : z = 1'h0;
	endcase // case (sel)
     end
endmodule // mux4_to_1
// Local Variable:
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design")
// End:
   
   
