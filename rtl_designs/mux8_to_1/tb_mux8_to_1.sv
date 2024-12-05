`timescale 1ns/1ns

module tb_mux8_to_1(); 
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			z;			// From DUT of mux8_to_1.v
// End of automatics
   reg [7:0] 		din;
   reg [2:0] 		sel;
 
mux8_to_1 DUT (/*AUTOINST*/
	       // Outputs
	       .z			(z),
	       // Inputs
	       .din			(din[7:0]),
	       .sel			(sel[2:0])); 
   initial sel[0] = 0;
   always #5 sel[0] = ~sel[0];

   initial sel[1] = 0;
   always #10 sel[1] = ~sel[1];

   initial sel[2] = 0;
   always #15 sel[2] = ~sel[2];
   

   initial begin
      din = 8'haa;
      #15
	din = 8'h4f;
      #15
	din = 8'hff;
      #15
	din = 8'hf5;
      $finish;
    end
	  
initial begin 
$dumpfile("tb_mux8_to_1.vcd"); 
$dumpvars(0,tb_mux8_to_1); 
end 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
