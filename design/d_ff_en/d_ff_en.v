`timescale 1ns/1ns 
module d_ff_en(/*AUTOARG*/
   // Inputs
   d, clk, rst, en, q
   );
   input d;
   input clk;
   input rst;
   input en;
   output q;
  
   /*AUTOINPUT*/
   /*AUTOOUTPUT*/ 
   /*AUTOREG*/ 
   /*AUTOWIRE*/
    
   reg	 d_nxt;
   reg	 d_reg;

   always@(posedge clk)
     begin
	if(!rst)
	  d_reg <= 1'b0;
	else
	  d_reg <= d_nxt;
     end

   always@(/*AUTOSENSE*/d or d_reg or en)
     begin
	//d_nxt = d_reg;
	if(en)
	  d_nxt = d;
	else
	  d_nxt = d_reg;
     end

   assign q = d_reg;
   
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/d_ff_en" ".")
// End:
