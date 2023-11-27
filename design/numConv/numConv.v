`timescale 1ns/1ns

module numConv #(parameter n = 4)(/*AUTOARG*/
   // Outputs
   bin_2_gray, gray_2_bin,
   // Inputs
   bin
   );

   input [n-1:0] bin;
   
   output [n-1:0] bin_2_gray;
   output reg [n-1:0] gray_2_bin;

   // bin_2_gray
   assign bin_2_gray = (bin >> 1) ^ bin;

   integer i;   
   // gray_2_bin
   always@(*) begin
      for(i=0; i<n ; i=i+1)
	       gray_2_bin[i] = ^(bin_2_gray >> i);
   end

   endmodule
