`timescale 1ns/1ns
`include "parameters.sv"
module barrel_shift_right (/*AUTOARG*/
   // Outputs
   out,
   // Inputs
   in, rot
   );

   input [`WIDTH-1:0] in;
   input [$clog2(`WIDTH)-1:0] rot;

   output [`WIDTH-1:0] 	 out;

   /*AUTOREG*/
   /*AUTOWIRE*/

   logic [`WIDTH-1:0] stg [$clog2(`WIDTH)-1:0];
   
    generate
    genvar i;
      assign stg[0] = rot[0] ? {in[0], in[`WIDTH-1:1]} : in;
      for (i = 1; i < $clog2(`WIDTH); i=i+1)begin
	       assign stg[i] = rot[i] ? {stg[i-1][`WIDTH-1:0], stg[i-1][`WIDTH-1:2**i]} : stg[i-1];
      end
      assign out = stg[$clog2(`WIDTH)-1];
   endgenerate 
endmodule // barrel_shift_right
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:

      
 

