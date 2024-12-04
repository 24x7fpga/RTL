`timescale 1ns/1ns 
module univ_cntr #(parameter n = 4)(/*AUTOARG*/
   // Outputs
   z,
   // Inputs
   clk, rst, d_in, ld, up
   );

   input  clk;
   input  rst;
   input  [n-1:0] d_in;
   input	 ld;
   input         up;
   output [n-1:0] z;
   
   /*AUTOINPUT*/

   /*AUTOOUTPUT*/
   
   /*AUTOREG*/ 

   /*AUTOWIRE*/ 


   reg [n-1:0]	  z_reg, z_nxt;
   
   always@(posedge clk)
     begin
	if(!rst)
	  z_reg <= 0;
	else
	  z_reg <= z_nxt;
     end

   always@(/*AUTOSENSE*/d_in or ld or up or z_reg)
     begin    
	casex({ld,up})
	  2'b00 : z_nxt = z_reg - 1;
	  2'b01 : z_nxt = z_reg + 1;
	  2'b10 : z_nxt = d_in;
	  2'b11 : z_nxt = z_reg;
	endcase // case ({ld,up})
     end

   assign z = z_reg;

endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
