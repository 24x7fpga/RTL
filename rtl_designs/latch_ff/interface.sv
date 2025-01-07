`include "package.svh"
interface latch_ff_intf (input i_clk);
   // Clock and Reset
   logic clk;
   logic rst;

   // Add all the signals
   logic       en;
   logic [3:0] in;
   logic [3:0] l_out;
   logic [3:0] d_r_out;
   logic [3:0] d_f_out;

   assign clk = i_clk;

   task reset();
      rst <= 1'b1;
      repeat (2) @(posedge i_clk);
      rst <= 1'b0;
   endtask // reset

   task run();
      for(int i = 0; i < 32; i++)begin
	 #($urandom_range(0,8)) en <= $random;
	 #($urandom_range(0,8)) in <= $random;
	 @(posedge clk);
      end
   endtask // run
   
endinterface // latch_ff_intf
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
