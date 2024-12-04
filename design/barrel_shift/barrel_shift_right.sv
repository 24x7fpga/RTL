`timescale 1ns/1ns
`include "parameters.sv"
module barrel_shift_right (/*AUTOARG*/
   // Outputs
   out_rh,
   // Inputs
   in, rt
   );

   input [`WIDTH-1:0] in;
   input [$clog2(`WIDTH)-1:0] rt; // rotate right

   output [`WIDTH-1:0] 	 out_rh;

   /*AUTOREG*/
   /*AUTOWIRE*/

   logic [`WIDTH-1:0] stg [$clog2(`WIDTH)-1:0];
   
    generate
    genvar i;
      assign stg[0] = rt[0] ? {in[0], in[`WIDTH-1:1]} : in;
      for (i = 1; i < $clog2(`WIDTH); i=i+1)begin
	       assign stg[i] = rt[i] ? {stg[i-1][(2*i)-1:0], stg[i-1][`WIDTH-1:2**i]} : stg[i-1];
      end
      assign out_rh = stg[$clog2(`WIDTH)-1];
   endgenerate 
endmodule // barrel_shift_right
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/barrel_shift" ".")
// End:

      
 

