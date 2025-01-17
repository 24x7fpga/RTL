`include "package.svh"
module tb_race_condition;
   // Clock
   logic      m_clk;
   // width parameter
   localparam N = 4;
  
   /*AUTOREG*/
   /*AUTOWIRE*/

   // Add Interface
   race_condition_intf #(.N(N)) intf (m_clk);

   race_condition #(/*AUTOINSTPARAM*/
		    // Parameters
		    .N			(N)) DUT (
						  // Outputs
						  .res			(intf.res[N:0]),
						  .res_vld		(intf.res_vld),
						  // Inputs
						  .a			(intf.a[N-1:0]),
						  .b			(intf.b[N-1:0]),
						  .arg_vld		(intf.arg_vld),
						  .clk			(intf.clk),
						  .rst			(intf.rst));

   // Generate Clock
   always #(`T/2) m_clk = (m_clk === 1'b0);

   initial begin
      intf.reset();
      intf.run();
      // End Sim
      $finish;
   end

   initial begin
      $dumpfile("tb_race_condition.vcd");
      $dumpvars(0,tb_race_condition);
   end
   
endmodule // tb_race_condition
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
