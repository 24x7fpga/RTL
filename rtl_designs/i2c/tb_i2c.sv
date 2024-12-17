`include "package.svh"
//`include "interface.sv"

module tb_i2c;
   // Clock
   logic      i_clk;
   
   tri sda, scl;
   
   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
//   wire [15:0]	o_data;			// From DUT of i2c.v
//   wire			s_busy;			// From DUT of i2c.v
//   wire			s_done;			// From DUT of i2c.v
//   tri1			scl;			// From DUT of i2c.v
//   tri1			sda;			// To/From DUT of i2c.v
   // End of automatics

   // Add Interface
   i2c_intf intf(i_clk);

   i2c DUT (/*AUTOINST*/
	    // Outputs
	    .scl			(intf.scl),
	    .o_data			(intf.o_data[15:0]),
	    .s_busy			(intf.s_busy),
	    .s_done			(intf.s_done),
	    .sda_en			(intf.sda_en),
	    // Inouts
	    .sda			(intf.sda),
	    // Inputs
	    .clk			(intf.clk),
	    .rst_n			(intf.rst_n),
	    .addr			(intf.addr[6:0]),
	    .cmd			(intf.cmd[7:0]),
	    .data			(intf.data[7:0]),
	    .rd_wr			(intf.rd_wr),
	    .init			(intf.init),
	    . wr            (intf.wr));

   // Generate Clock
   always #(`T/2) i_clk = (i_clk === 1'b0);

   // Model PULL REGISTERS
   pullup (intf.sda);
   assign intf.sda = (intf.sda_res) ? intf.sda_trans: 1'bz;
   pullup (intf.scl);
   assign intf.scl = 1'bz;
   
   assign sda = intf.sda;
   assign scl = intf.scl;

   initial begin
      intf.reset();
      intf.write(7'h48,8'h01,8'h23);
      intf.write(7'h48,8'h10,8'h47);
      intf.recev(7'h48,8'h01);
      intf.recev(7'h48,8'h00);
      intf.recev(7'h48,8'h03);
      // End Sim
      $finish;
   end

   initial begin
      $dumpfile("tb_i2c.vcd");
      $dumpvars(0,tb_i2c);
   end
   
endmodule // tb_i2c
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
