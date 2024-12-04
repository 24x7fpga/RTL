`timescale 1ns/1ns 
module block_vs_non_block(/*AUTOARG*/
   // Outputs
   x, y, z, xb, yb, zb,
   // Inputs
   clk, rst
   ); 
   input       clk; 
   input       rst;

   output logic	x,y,z;       // Non-blocking outputs
   output logic	xb,yb,zb;    // BLocking outputs
   
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 

   logic	a = 1;
   logic	b = 0;
   logic	c = 1;
   

   // Blocking example
   always_comb
     begin
	if(rst)begin
	   xb = 0;
	   yb = 0;
	   zb = 0;
	end else begin
	   xb = a | b;
	   yb = xb ^ c;
	   zb = yb;
	end
     end // always_comb

   // Non-blocking example
   always_ff@(posedge clk)
     begin
	if(rst)begin
	   x <= 0;
	   y <= 0;
	   z <= 0;
	end else begin
	   x<= a | b;
	   y <= x ^ c;
	   z <= y;
	end
     end // always_ff@ (posedge clk)
   
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/block_vs_non_block" ".")
// End:
