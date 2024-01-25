`timescale 1ns/1ns
`include "parameters.sv" 
module tb_barrel_shift();
   reg [`WIDTH-1:0] in;
   reg [$clog2(`WIDTH)-1:0] rot;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [`WIDTH-1:0]	out;			// From DUT of barrel_shift.v
   // End of automatics
   barrel_shift DUT (/*AUTOINST*/
		     // Outputs
		     .out		(out[`WIDTH-1:0]),
		     // Inputs
		     .in		(in[`WIDTH-1:0]),
		     .rot		(rot[$clog2(`WIDTH)-1:0])); 
   
   initial in = 'h4f; 
   initial rot = 'h1;
 
   
   initial begin 
      $dumpfile("tb_barrel_shift.vcd"); 
      $dumpvars(0,tb_barrel_shift); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
