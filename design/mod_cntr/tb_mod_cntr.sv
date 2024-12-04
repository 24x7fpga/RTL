`timescale 1ns/1ns 
module tb_mod_cntr(); 
   localparam t = 10;
   localparam N = 10;
   
   logic      clk; 
   logic      rst;
   
   logic [N-1:0] din;
   logic [N-1:0] exp_out;

   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [N-1:0]		mod_cntr;		// From DUT of mod_cntr.v
   // End of automatics
   
   mod_cntr #(/*AUTOINSTPARAM*/
	      // Parameters
	      .N			(N)) DUT (/*AUTOINST*/
						  // Outputs
						  .mod_cntr		(mod_cntr[N-1:0]),
						  // Inputs
						  .clk			(clk),
						  .rst			(rst)); 
   
   always #(t/2) clk = (clk === 1'b0);

   
   task reset();
      rst <= 1;
      repeat(3)@(posedge clk);
      rst <= 0;
   endtask; // reset
   
  
 // function to verify mod counter
   function [N-1:0] mod_veri (input [N-1:0] din);
      logic [N-1:0] dout;
      dout = din % N;
      return dout;
   endfunction // mod_veri

   always_ff@(posedge clk)
      if(rst)
	din <= 0;
      else
	din <= din + 1;

  
   task comp_result(input [N-1] exp_out, mod_cntr);
      begin
	 // check the result
	 if(exp_out == mod_cntr)begin
	   $display("Cntr = %0d, Exp_Mod_Cntr = %0d, Mod_Cntr = %0d", din, exp_out, mod_cntr);
	 end else begin
	    $display("Simulation Fail ;(");
	    $display("Cntr = %0d, Exp_Mod_Cntr = %0d, Mod_Cntr = %0d", din, exp_out, mod_cntr);
	    //$finish;
	 end
     end 
   endtask // comp_result
   
	 
   initial begin 
      reset();
      
      for(int i = 0; i < 40; i = i+1)begin
	 exp_out = mod_veri(din);
	 comp_result(exp_out, mod_cntr);
	 @(posedge clk);
      end
      
      $finish;
   end
 
   initial begin 
      $dumpfile("tb_mod_cntr.vcd"); 
      $dumpvars(0,tb_mod_cntr); 
   end
 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/mod_cntr" ".")
// End:
