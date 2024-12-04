`timescale 1ns/1ns 
module tb_rom(); 
   localparam t = 10;
   localparam N = 7;
   
   logic      en;
   logic [$clog2(N):0] addr;
   
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [N-1:0]		data;			// From DUT of rom.v
   // End of automatics
   
   rom #(/*AUTOINSTPARAM*/
	 // Parameters
	 .N				(N)) DUT (/*AUTOINST*/
						  // Outputs
						  .data			(data[N-1:0]),
						  // Inputs
						  .addr			(addr[$clog2(N):0]),
						  .en			(en));
   
   initial begin
      addr = 0;
      en   = 0; 
      #(2*t); 
      en = 1;
      $display("<- Read data from ROM ->");
      for(int i=0; i<16; i=i+1)begin
	 $display("Addr = %0d, Data = %b", addr, data);
	 #t;
	 addr = addr +1;
      end
      $finish;
   end 

endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/rom" ".")
// End:
