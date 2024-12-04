`include "package.svh" 
module tb_apb; 

   logic      clk;
 
   apb_intf intf(clk);

   apb DUT (
	    // Outputs
	    .m_paddr			(intf.m_paddr[`WIDTH-1:0]),
	    .m_pwdata			(intf.m_pwdata[`WIDTH-1:0]),
	    .m_pselx			(intf.m_pselx[3:0]),
	    .m_en			(intf.m_en),
	    .m_pwrite			(intf.m_pwrite),
	    .m_pready			(intf.m_pready),
	    .m_prdata			(intf.m_prdata[`WIDTH-1:0]),
	    // Inputs
	    .p_addr			(intf.p_addr[`WIDTH-1:0]),
	    .pw_data			(intf.pw_data[`WIDTH-1:0]),
	    .p_sel			(intf.p_sel[3:0]),
	    .p_wr			(intf.p_wr),
	    .trans			(intf.trans),
	    .pclk			(intf.pclk),
	    .presetn			(intf.presetn));

   always #(`T/2) clk = (clk === 1'b0);

   
   initial begin
      intf.reset();

      // UART tranmisssion
      // set braud rate
      intf.m_br(11'd66);
      // send data
      intf.send(8'd86);
      // wait for transmission
      intf.read_status();
      // read data
      intf.read();

      // send data
      intf.send(8'd14);
      // wait for transmission
      intf.read_status();
      // read data
      intf.read();
     
 
      // send data
      intf.send(8'd78);
      // wait for transmission
      intf.read_status();
      // read data
      intf.read();

      // send data
      intf.send(8'd99);
      // wait for transmission
      intf.read_status();
      // read data
      intf.read();
      $finish;
   end
   
   initial begin 
      $dumpfile("tb_apb.vcd"); 
      $dumpvars(0,tb_apb); 
   end 
 
 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/apb" ".")
// End: 
