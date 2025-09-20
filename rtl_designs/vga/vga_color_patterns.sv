`timescale 1ns/1ns
module vga_color_patterns (/*AUTOARG*/
   // Outputs
   r, g, b,
   // Inputs
   clk, rst, active, sw
   );
   // Outputs
   output [7:0] r;
   output [7:0]	g;
   output [7:0]	b;
   // Inputs
   input	clk;
   input	rst;
   input	active;
   input [3:0]	sw;

   logic [7:0]	s_r, s_g, s_b;
   
   // red color
   always_comb begin
      case(sw)
	4'h0 : {s_r,s_g,s_b} = {8'hFF, 8'h00, 8'h00};
	4'h1 : {s_r,s_g,s_b} = {8'h00, 8'hFF, 8'h00};
	4'h2 : {s_r,s_g,s_b} = {8'h00, 8'h00, 8'hFF};
	4'h3 : {s_r,s_g,s_b} = {8'h47, 8'h78, 8'h19};
	default : {s_r,s_g,s_b} = {8'hFF, 8'hAA, 8'h00};
      endcase // case (sw)
   end

   assign {r,g,b} = (active) ? {s_r, s_g, s_b} : {8'h0,8'h0,8'h0};

endmodule // vga_color_patterns
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
