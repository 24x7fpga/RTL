`include "package.svh"
module tb_valid_ready_pipeline;
   // Master Clock
   logic      m_clk;
   // Data Width
   localparam N = 4;
   // Pipeline depth
   localparam P = 4;
   // Valid/Ready Version 
   localparam V = 0;

   // Add Interface
   valid_ready_pipeline_intf #(N,P,V) intf (m_clk);

   valid_ready_pipeline #(
			  // Parameters
			  .N  (N),
			  .P  (P),
			  .V  (V))  DUT (
					 // Outputs
					 .up_data		(intf.up_data[N-1:0]),
					 .up_vld		(intf.up_vld),
					 .dwn_rdy		(intf.dwn_rdy),
					 // Inputs
					 .up_rdy		(intf.up_rdy),
					 .dwn_vld		(intf.dwn_vld),
					 .dwn_data		(intf.dwn_data[N-1:0]),
					 .clk			(intf.clk),
					 .rst			(intf.rst));

   // Generate Clock
   always #(`T/2) m_clk = (m_clk === 1'b0);

   initial begin
      intf.reset();
      intf.run();
      //intf.back_pressure();
      // End Sim
      $finish;
   end

   initial begin
      $dumpfile("tb_valid_ready_pipeline.vcd");
      $dumpvars(0,tb_valid_ready_pipeline);
   end
   
endmodule // tb_valid_ready_pipeline
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
