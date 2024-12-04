`timescale 1ns/1ns 
module tb_pwm();
   localparam t = 10;
   localparam n = 8;
   reg	      clk;
   reg	      rst;
   reg [n:0]	   duty;
   reg [31:0]      dvsr;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			pwm;			// From DUT of pwm.v
   // End of automatics
  
   pwm #(.n(n)) DUT (/*AUTOINST*/
	    // Outputs
	    .pwm			(pwm),
	    // Inputs
	    .clk			(clk),
	    .rst			(rst),
	    .duty			(duty[n:0]),
	    .dvsr			(dvsr[31:0])); 
   
   initial clk = 0; 
   always #(t/2) clk = ~clk; 

   initial begin
      rst = 1'b0;
      #(2*t);
      rst = 1'b1;
   end

   initial begin
      dvsr = 'd195;
      //duty = 'd64;       // 25%
      duty = 'd128;      // 50%
      //duty = 'd192;      // 75% 
      #(8000*256*t);
      $finish;
   end // initial begin   
   
   initial begin 
      $dumpfile("tb_pwm.vcd"); 
      $dumpvars(0,tb_pwm); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/pwm" ".")
// End:
