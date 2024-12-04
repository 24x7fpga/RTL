`timescale 1ns/1ns 
module tb_fibonacci(); 
   localparam t = 8; 
   logic clk; 
   logic rst; 

   localparam N = 16;
   logic en;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [N-1:0]		f_num;			// From DUT of fibonacci.v
   // End of automatics

   
   fibonacci #(/*AUTOINSTPARAM*/
	       // Parameters
	       .N			(N)) DUT (/*AUTOINST*/
						  // Outputs
						  .f_num		(f_num[N-1:0]),
						  // Inputs
						  .clk			(clk),
						  .rst			(rst),
						  .en			(en)); 
   
   initial clk = 1; 
   always #(t/2) clk = ~clk; 

   initial begin
      en  = 0;
      rst = 0; 
      #(2*t); 
      rst = 1;
      #(2*t);
      en  = 1;
      #(10*t);
      en  = 0;
      #(5*t);
      en  = 1;
      #(10*t);
      $finish;
   end 
   
   always@(posedge clk)
     begin
	$display("EN=%d Fibonacci=%d",en, f_num);
     end
   
   initial begin 
      $dumpfile("tb_fibonacci.vcd"); 
      $dumpvars(0,tb_fibonacci); 
   end 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
