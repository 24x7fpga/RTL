module tb_numConv();
   parameter n = 4;
 
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire [n-1:0]		bin_2_gray;		// From DUT of numConv.v
wire [n-1:0]		gray_2_bin;		// From DUT of numConv.v
// End of automatics
//reg clk; 
//reg rst;
   reg [n-1:0] bin;
 
numConv #(.n(n)) DUT (/*AUTOINST*/
	     // Outputs
	     .bin_2_gray		(bin_2_gray[n-1:0]),
	     .gray_2_bin		(gray_2_bin[n-1:0]),
	     // Inputs
	     .bin			(bin[n-1:0])); 
//initial clk = 0; 
//always #5 clk = ~clk; 


initial begin 
$dumpfile("tb_numConv.vcd"); 
$dumpvars(0,tb_numConv); 
end


   initial begin
      bin = 4'ha;
      #10;
      $finish;
   end
   
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/numConv") 
// End:

















