`timescale 1ns/1ns
`include "parameters.sv"
module barrel_shift_left (/*AUTOARG*/
   // Outputs
   out_lf,
   // Inputs
   in, rt
   );

   input [`WIDTH-1:0] in;
   input [$clog2(`WIDTH)-1:0] rt; // rotate left

   output [`WIDTH-1:0] 	 out_lf;

   /*AUTOREG*/
   /*AUTOWIRE*/

   logic [`WIDTH-1:0] stg [$clog2(`WIDTH)-1:0];
   
    generate
    genvar i;
      assign stg[0] = rt[0] ? {in[`WIDTH-2:0], in[`WIDTH-1]} : in;
      for (i = 1; i < $clog2(`WIDTH); i=i+1)begin
	       assign stg[i] = rt[i] ? {stg[i-1][(`WIDTH-(2*i)):0], stg[i-1][`WIDTH-1:(`WIDTH - (2**i))]} : stg[i-1];
      end
      assign out_lf = stg[$clog2(`WIDTH)-1];
   endgenerate 
endmodule // barrel_shift_left
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:

      
 
