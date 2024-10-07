`timescale 1ns/1ns 
module rom #(parameter N = 7)(/*AUTOARG*/
   // Outputs
   data,
   // Inputs
   addr, en
   );
   // output
   output [N-1:0] data;
   //input
   input [$clog2(N):0] addr;
   input	       en;
   
  /*AUTOREG*/ 
  /*AUTOWIRE*/ 

   reg [N-1:0]       mem [0:9];

   initial
     begin
	$display("-------- Loading ROM --------");
	$readmemb("memory.mem", mem);
     end

   assign data = (en && (addr <= 'h9)) ? mem[addr] : 'h0;
   	
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
