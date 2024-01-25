`timescale 1ns/1ns
`include "parameters.sv" 
module tb_barrel_shift();
   reg [`WIDTH-1:0] in;
   reg [$clog2(`WIDTH)-1:0] rt;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [`WIDTH-1:0]	out_lf;			// From DUT of barrel_shift.v
   wire [`WIDTH-1:0]	out_rh;			// From DUT of barrel_shift.v
   // End of automatics
   barrel_shift DUT (/*AUTOINST*/
		     // Outputs
		     .out_rh		(out_rh[`WIDTH-1:0]),
		     .out_lf		(out_lf[`WIDTH-1:0]),
		     // Inputs
		     .in		(in[`WIDTH-1:0]),
		     .rt		(rt[$clog2(`WIDTH)-1:0])); 
   
   initial in = 'hf04f; 
   initial rt = 'h5;

  initial begin
     #20;  
     $finish;
  end
   
   
   initial begin 
      $dumpfile("tb_barrel_shift.vcd"); 
      $dumpvars(0,tb_barrel_shift); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
