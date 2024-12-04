`timescale 1ns/1ns

module tb_demux1_to_4(); 
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [3:0]		z;			// From DUT of demux1_to_4.v
// End of automatics
   
   reg 			din;
   reg [1:0] 		sel;
   
demux1_to_4 DUT (/*AUTOINST*/
		 // Outputs
		 .z			(z[3:0]),
		 // Inputs
		 .din			(din),
		 .sel			(sel[1:0])); 

   initial begin
      din = 0;
      sel = 2'h0;
   end

   always #5  din = ~din;
   always #10 sel[0] = ~sel[0];
   always #20 sel[1] = ~sel[1];
  
  initial begin
     #40
       $finish;
  end
   
   initial begin 
      $dumpfile("tb_demux1_to_4.vcd"); 
      $dumpvars(0,tb_demux1_to_4); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/demux1_to_4" ".")
// End:
