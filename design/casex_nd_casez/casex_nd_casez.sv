`timescale 1ns/1ns 
module casex_nd_casez(/*AUTOARG*/
   // Outputs
   casex_x, casex_z, casex_q, casez_x, casez_z, casez_q,
   // Inputs
   sel
   ); 
   // outputs
   output [1:0] casex_x;
   output [1:0] casex_z;
   output [1:0] casex_q;
   output [1:0] casez_x;
   output [1:0] casez_z;
   output [1:0] casez_q;
   // inputs
   input [3:0]	sel;
   
  /*AUTOREG*/ 
  // Beginning of automatic regs (for this module's undeclared outputs)
  reg [1:0]		casex_q;
  reg [1:0]		casex_x;
  reg [1:0]		casex_z;
  reg [1:0]		casez_q;
  reg [1:0]		casez_x;
  reg [1:0]		casez_z;
  // End of automatics
  /*AUTOWIRE*/ 

   always_comb begin
      casex(sel)
	4'b0001 : casex_x = 2'b00;
	4'b001x : casex_x = 2'b01;
	4'b01xx : casex_x = 2'b10;
	4'b1xxx : casex_x = 2'b11;
	default : casex_x = 2'b00;
      endcase // casex (sel)
   end
 
   // note '?' is an alias for z
   always_comb begin
      casex(sel)
	4'b0001 : casex_z = 2'b00;
	4'b001z : casex_z = 2'b01;
	4'b01zz : casex_z = 2'b10;
	4'b1zzz : casex_z = 2'b11;
	default : casex_z = 2'b00;
      endcase // casex (sel)
   end
 
   always_comb begin
      casex(sel)
	4'b0001 : casex_q = 2'b00;
	4'b001? : casex_q = 2'b01;
	4'b01?? : casex_q = 2'b10;
	4'b1??? : casex_q = 2'b11;
	default : casex_q = 2'b00;
      endcase // casex (sel)
   end
   
   always_comb begin
      casez(sel)
	4'b0001 : casez_x = 2'b00;
	4'b001x : casez_x = 2'b01;
	4'b01xx : casez_x = 2'b10;
	4'b1xxx : casez_x = 2'b11;
	default : casez_x = 2'b00;
      endcase // casez (sel)
   end
   
   // note '?' is an alias for z
   always_comb begin
      casez(sel)
	4'b0001 : casez_z = 2'b00;
	4'b001z : casez_z = 2'b01;
	4'b01zz : casez_z = 2'b10;
	4'b1zzz : casez_z = 2'b11;
	default : casez_z = 2'b00;
      endcase // casez (sel)
   end

   // good design practice 
   always_comb begin
      casez(sel)
	4'b0001 : casez_q = 2'b00;
	4'b001? : casez_q = 2'b01;
	4'b01?? : casez_q = 2'b10;
	4'b1??? : casez_q = 2'b11;
	default : casez_q = 2'b00;
      endcase // casez (sel)
   end

 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
