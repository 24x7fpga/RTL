`include "package.svh"
module valid_ready_var2 #(parameter N = 4) (/*AUTOARG*/
   // Outputs
   up_data, up_vld, dwn_rdy,
   // Inputs
   up_rdy, dwn_vld, dwn_data, clk, rst
   );
   // Outputs
   // up stream
   output [N-1:0] up_data;
   output	  up_vld;
   // down stream
   output	  dwn_rdy;
   // Inputs
   // up stream 
   input	  up_rdy;
   // down stream
   input	  dwn_vld;
   input [N-1:0]  dwn_data;

   input	  clk;
   input	  rst;
   
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [N-1:0]	  up_data;
   reg		  up_vld;
   // End of automatics
   /*AUTOWIRE*/
   
   logic	  up_vld_reg;
    
   always_ff@(posedge clk) begin
      if(dwn_vld & (up_rdy | dwn_rdy)) begin 
	 up_data <= dwn_data;
      end
   end

   always_ff@(posedge clk, posedge rst)begin 
    if(rst)
        up_vld_reg  <= 1'b0;
    else begin
        if(dwn_vld & (up_rdy | dwn_rdy)) 
            up_vld_reg <= 1'b1;
        else if(up_vld & dwn_rdy) 
            up_vld_reg <= 1'b0;
    end
   end
   
   assign dwn_rdy = up_rdy | ~up_vld_reg; 
   assign up_vld  = up_vld_reg;

endmodule // valid_ready_var2
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
