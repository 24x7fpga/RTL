//////////////////////////////////////////////////////////////////////
// DOC: https://github.com/24x7fpga/iVerilog/blob/master/doc/demux.org 
//////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module demux1_to_8(/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   din, sel
   );
   input din;
   input [2:0] sel;
   output [7:0] z;
   
/*AUTOREG*/ 
/*AUTOWIRE*/

   wire [3:0] 	tempz1;
   wire [3:0] 	tempz2;
   
demux1_to_4 DEM1 (/*AUTOINST*/
		  // Outputs
		  .z			(tempz1[3:0]),
		  // Inputs
		  .din			(din),
		  .sel			(sel[1:0])); 
demux1_to_4 DEM2 (/*AUTOINST*/
		  // Outputs
		  .z			(tempz2[3:0]),
		  // Inputs
		  .din			(din),
		  .sel			(sel[1:0]));
   
   assign z = sel[2] ? {tempz2,4'h0} : {4'h0,tempz1};
   
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
