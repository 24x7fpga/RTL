`timescale 1ns/1ns 
module tb_freq_div(); 
   localparam t = 10;
   parameter  n = 8;
   
   reg clk; 
   reg rst; 

   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			div2;			// From DUT of freq_div.v
   wire			div3;			// From DUT of freq_div.v
   wire			div4;			// From DUT of freq_div.v
   wire			div5;			// From DUT of freq_div.v
   wire			div6;			// From DUT of freq_div.v
   wire			div7;			// From DUT of freq_div.v
   // End of automatics

   freq_div #(/*AUTOINSTPARAM*/
	      // Parameters
	      .n			(n)) DUT (/*AUTOINST*/
						  // Outputs
						  .div2			(div2),
						  .div4			(div4),
						  .div6			(div6),
						  .div3			(div3),
						  .div5			(div5),
						  .div7			(div7),
						  // Inputs
						  .clk			(clk),
						  .rst			(rst)); 

   initial clk = 1; 
   always #(t/2) clk = ~clk; 

   initial begin 
      rst = 0; 
      #(2*t); 
      rst = 1; 
   end

   initial begin
      #(50*t);
      $finish;
   end
      
   initial begin 
      $dumpfile("tb_freq_div.vcd"); 
      $dumpvars(0,tb_freq_div); 
   end 
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
