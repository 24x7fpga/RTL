`timescale 1ns/1ns

module vga_ctrl (/*AUTOARG*/
   // Outputs
   h_sync, v_sync, active,
   // Inputs
   clk, rst
   );
   // Output
   output h_sync;
   output v_sync;
   output active;
   // Inputs
   input  clk;
   input  rst;

   /*AUTOWIRE*/
   /*AUTOREG*/

   logic [11:0]	h_count, v_count;
   
   logic [11:0]	h_total;
   logic [11:0]	v_total;

   assign h_total = `HSYNC_PULSE + `HBACK_PORCH + `HACTIVE + `HFRONT_PORCH;
   assign v_total = `VSYNC_PULSE + `VBACK_PORCH + `VACTIVE + `VFRONT_PORCH;
   

   // hsync and vsync counter
   always_ff@(posedge clk)begin
      if(rst)begin
	 h_count <= '0;
	 v_count <= '0; 
      end else begin
	 h_count <= (h_count == h_total - 1) ? '0 : h_count + 1;
	 v_count <= (v_count == v_total - 1) ? '0 : (h_count == h_total - 1) ? v_count + 1 : v_count;
      end
   end

   // generate hsync and vsync
   assign h_sync = ~(h_count < `HSYNC_PULSE);
   assign v_sync = ~(v_count < `VSYNC_PULSE);

   // generate active area
   assign h_active = (h_count > (`HSYNC_PULSE + `HBACK_PORCH) && h_count < (`HSYNC_PULSE + `HBACK_PORCH + `HACTIVE)); 
   assign v_active = (v_count > (`VSYNC_PULSE + `VBACK_PORCH) && v_count < (`VSYNC_PULSE + `VBACK_PORCH + `VACTIVE));

   assign active = (h_active & v_active);
   
endmodule // vga_ctrl
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
