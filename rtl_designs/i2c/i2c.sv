`include "package.svh"
module i2c (/*AUTOARG*/
   // Outputs
   scl, o_data, s_busy, s_done, sda_en,
   // Inouts
   sda,
   // Inputs
   clk, rst_n, addr, cmd, data, rd_wr, init, wr
   );
   // Outputs
   inout  tri1    sda;
   output tri1    scl;
   output [15:0] o_data;

   output	 s_busy;
   output	 s_done;
   output    sda_en;

   
   // Inputs
   input	 clk;
   input	 rst_n;
   input [6:0]	 addr;
   input [7:0]	 cmd;
   input [7:0]	 data;
   input	 rd_wr;
   input	 init;
   input     wr;
   

   /*AUTOREG*/
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			busy;			// From MSTR of i2c_master.v
   wire			done;			// From MSTR of i2c_master.v
//   wire			i_sda;			// From CTRL of i2c_ctrl.v
   wire			o_scl;			// From MSTR of i2c_master.v
   wire			o_sda;			// From MSTR of i2c_master.v
   wire			rw;			// From CTRL of i2c_ctrl.v
   wire			rx_ack;			// From CTRL of i2c_ctrl.v
   wire [7:0]		rx_data;		// From MSTR of i2c_master.v
   wire			sda_en;			// From CTRL of i2c_ctrl.v
   wire			start;			// From CTRL of i2c_ctrl.v
   wire [7:0]		tx_data;		// From CTRL of i2c_ctrl.v
   // End of automatics

reg i_sda;

   i2c_ctrl CTRL (/*AUTOINST*/
		  // Outputs
		  .sda_en		(sda_en),
		  .tx_data		(tx_data[7:0]),
		  .start		(start),
		  .o_data		(o_data[15:0]),
		  .rw			(rw),
		  .rx_ack		(rx_ack),
		  .wr           (wr),
		  // Inputs
		  .clk			(clk),
		  .rst_n		(rst_n),
		  .init			(init),
		  .busy			(busy),
		  .done			(done),
		  .rd_wr		(rd_wr),
		  .addr			(addr[6:0]),
		  .cmd			(cmd[7:0]),
		  .data			(data[7:0]),
		  .rx_data		(rx_data[7:0]));

   i2c_master MSTR (/*AUTOINST*/
		    // Outputs
		    .o_sda		(o_sda),
		    .o_scl		(o_scl),
		    .busy		(busy),
		    .done		(done),
		    .rx_data		(rx_data[7:0]),
		    // Inputs
		    .clk		(clk),
		    .rst_n		(rst_n),
		    .rw			(rw),
		    .start		(start),
		    .i_sda		(i_sda),
		    .rx_ack		(rx_ack),
		    .tx_data		(tx_data[7:0]));

   assign s_busy = busy;
   assign s_done = done;
   
   assign i_sda = sda;
   
   // Assign Outputs
   assign sda = (sda_en) ? rx_ack : ((o_sda) ? 1'bz : o_sda);
   assign scl = (o_scl)  ? 1'bz : o_scl;
   

endmodule // i2c
// Local Variables:
// Verilog-Library-Directories: (".")
// End:
