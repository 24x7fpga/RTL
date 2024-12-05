module tb_mux4_to_1(); 
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			z;			// From DUT of mux4_to_1.v
// End of automatics
reg [3:0] din; 
reg [1:0] sel;
 
mux4_to_1 DUT (/*AUTOINST*/
	       // Outputs
	       .z			(z),
	       // Inputs
	       .din			(din[3:0]),
	       .sel			(sel[1:0])); 

  initial sel[0] = 0;  
  always #5 sel[0] = ~sel[0];

   initial sel[1] = 0;
   always #10 sel[1] = ~sel[1];

   initial begin
      din = 4'hb;
      #40
	din = 4'h3;
      #40
	din = 4'hf;
      #40
	din = 4'h6;
      $finish;
   end
   
initial begin 
$dumpfile("tb_mux4_to_1.vcd"); 
$dumpvars(0,tb_mux4_to_1); 
end 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
