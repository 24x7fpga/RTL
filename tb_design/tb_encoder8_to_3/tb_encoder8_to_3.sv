`timescale 1ns/1ns 
module tb_encoder8_to_3(); 
   localparam t = 10;
   localparam width = 8;
   

   logic [width-1:0] in;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [$clog2(width)-1:0] out;		// From DUT of encoder8_to_3.v
   // End of automatics
   encoder8_to_3 #(/*AUTOINSTPARAM*/
		  // Parameters
		  .width		(width)) DUT (/*AUTOINST*/
						      // Outputs
						      .out		(out[$clog2(width)-1:0]),
						      // Inputs
						      .in		(in[width-1:0])); 
   

   logic [$clog2(width)-1:0] k;
   
   initial begin
      repeat(50)begin
	 k = $urandom_range(0,width-1);
	 in = {8{1'b0}};
	 in[k] = 1'b1;
	 #t;	 
	 $display("Exp Result = %0d, Result = %0d", k, out);
	 if(k != out)begin
	    $display("simulation FAIL ;(\n");
	    $finish;
	 end
      end
      $display("Simulation PASS ;)");
      $finish;
      
   end
   

   
   initial begin 
      $dumpfile("tb_encoder8_to_3.vcd"); 
      $dumpvars(0,tb_encoder8_to_3); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
