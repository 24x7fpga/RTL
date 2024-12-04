//////////////////////////////////////////////////////////////////////
// DOC: https://github.com/24x7fpga/iVerilog/blob/master/doc/demux.org 
//////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module demux1_to_4(/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   din, sel
   );
   input din;
   input [1:0] sel;
   output reg [3:0] z;
   
/*AUTOREG*/ 
/*AUTOWIRE*/

   always@(*)
     begin
	z = 4'h0;
	case(sel)
	  2'h0 : z[0] = din;
	  2'h1 : z[1] = din;
	  2'h2 : z[2] = din;
	  2'h3 : z[3] = din;
	endcase // case (sel)
     end
 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
