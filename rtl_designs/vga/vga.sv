`include "package.svh"
module vga (/*AUTOARG*/
   // Outputs
   r, g, b, h_synv, v_sync,
   // Inputs
   clk, rst, sw
   );
   // Outputs
   output [7:0]	r;
   output [7:0]	g;
   output [7:0]	b;
   output	h_synv;
   output	v_sync;
   // Inputs
   input	clk;
   input	rst;
   input [3:0]	sw;
   
   

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			h_synv;
   reg			v_sync;
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			pixel_clk;		// From PIXEL_CLK of vga_clk_gen.v
   // End of automatics

   vga_clk_gen #(.D(5)) PIXEL_CLK (/*AUTOINST*/
				   // Outputs
				   .pixel_clk		(pixel_clk),
				   // Inputs
				   .clk			(clk),
				   .rst			(rst));

   vga_ctrl CTRL (
		  // Outputs
		  .h_sync		(h_sync),
		  .v_sync		(v_sync),
		  .active		(active),
		  // Inputs
		  .clk			(pixel_clk),
		  .rst			(rst));

   vga_color_patterns CLR_PATTERN (/*AUTOINST*/
				   // Outputs
				   .r			(r[7:0]),
				   .g			(g[7:0]),
				   .b			(b[7:0]),
				   // Inputs
				   .clk			(clk),
				   .rst			(rst),
				   .active		(active),
				   .sw			(sw[3:0]));
   

endmodule // vga
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
