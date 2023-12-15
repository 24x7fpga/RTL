`timescale 1ns/1ns

module tb_demux1_to_8(); 
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire [7:0]		z;			// From DUT of demux1_to_8.v
// End of automatics

   reg 			din;
   reg [2:0] 		sel;
   
   
demux1_to_8 DUT (/*AUTOINST*/
		 // Outputs
		 .z			(z[7:0]),
		 // Inputs
		 .din			(din),
		 .sel			(sel[2:0])); 
   
   initial din = 0; 
   always #5 din = ~din; 

   
   initial sel[0] = 0; 
   always #10 sel[0] = ~sel[0]; 
  
   initial sel[1] = 0; 
   always #20 sel[1] = ~sel[1];

 
   initial sel[2] = 0; 
   always #40 sel[2] = ~sel[2]; 
  
   initial begin
      #80
      $finish;
   end
   
 
   initial begin 
      $dumpfile("tb_demux1_to_8.vcd"); 
      $dumpvars(0,tb_demux1_to_8); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
