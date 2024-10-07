module tb_numConv();
   parameter n = 4;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [n-1:0]	bin_2_gray;		// From DUT of numConv.v
   wire [n-1:0]	gray_2_bin;		// From DUT of numConv.v
   // End of automatics
   
   reg [n-1:0]	bin;
   reg [n-1:0]	exp_gray;
   
   
   numConv #(.n(n)) DUT (/*AUTOINST*/
			 // Outputs
			 .bin_2_gray		(bin_2_gray[n-1:0]),
			 .gray_2_bin		(gray_2_bin[n-1:0]),
			 // Inputs
			 .bin			(bin[n-1:0])); 

   //function to test the DUT
   function [n-1:0] code_conv (input [n-1:0] bin);
      
      logic [n-1:0] gray;

      gray = bin^(bin >> 1);

      return gray;
   endfunction // code_conv
  

   initial begin
      for(int i=0; i<2*(2**n); i=i+1)begin
	 bin = $urandom();
	 exp_gray = code_conv(bin);
	 #10;
	 if((exp_gray == bin_2_gray) && (bin == gray_2_bin))
	   $display("In = %0d, Exp_Gray = %0d, Gray = %0d, Bin = %0d", bin, exp_gray, bin_2_gray, gray_2_bin);
	 else begin
	    $display("Simulation Fail ;(");
	    $display("In = %0d, Exp_Gray = %0d, Gray = %0d, Bin = %0d", bin, exp_gray, bin_2_gray, gray_2_bin);
	    $finish;
	 end
      end
      $display("Simulation Pass ;)");
   end // initial begin
   
 

   initial begin 
      $dumpfile("tb_numConv.vcd"); 
      $dumpvars(0,tb_numConv); 
   end

   
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/numConv") 
// End:

















