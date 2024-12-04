`timescale 1ns/1ns 
module tb_decoder3_to_8(); 
   localparam t = 10;
   localparam width = 3;

   logic [width-1:0] in;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [2**width-1:0]	out;			// From DUT of decoder3_to_8.v
   // End of automatics
   decoder3_to_8 #(/*AUTOINSTPARAM*/
		   // Parameters
		   .width		(width)) DUT (/*AUTOINST*/
						      // Outputs
						      .out		(out[2**width-1:0]),
						      // Inputs
						      .in		(in[width-1:0])); 

   
   initial begin
      repeat(50)begin
	 in  = $urandom_range(0, 2**width-1);
	 #(t);
	 if(out == 2**in)
	   $display("Input = %0d Expected result = %0d, Result = %0d", in, 2**in, out);
	 else begin
	   $display("Simulation FAIL ;( \n");
	   $finish;
	 end
      end
      $display("Simulation PASS ;) \n");
      $finish;
   end // initial begin
   
   initial begin 
      $dumpfile("tb_decoder3_to_8.vcd"); 
      $dumpvars(0,tb_decoder3_to_8); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/decoder3_to_8" ".")
// End:
