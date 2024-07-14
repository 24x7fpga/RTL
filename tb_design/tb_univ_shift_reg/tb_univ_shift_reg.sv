`timescale 1ns/1ns 
module tb_univ_shift_reg(); 
   localparam t = 10;
   localparam N = 4;
   localparam R = 20;
   
   
   logic      clk; 
   logic      rst; 

   logic [N-1:0] din;
   logic [$clog2(N)-1:0] sel;

   logic [N-1:0]		 queue_res [$];
   logic [N-1:0]		 exp_res;
   
   logic		 sim_done;
   
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [N-1:0]		dout;			// From DUT of univ_shift_reg.v
   // End of automatics
   univ_shift_reg #(/*AUTOINSTPARAM*/
		    // Parameters
		    .N			(N)) DUT (/*AUTOINST*/
						  // Outputs
						  .dout			(dout[N-1:0]),
						  // Inputs
						  .din			(din[N-1:0]),
						  .sel			(sel[$clog2(N)-1:0]),
						  .clk			(clk),
						  .rst			(rst)); 
   
   always #(t/2) clk = (clk === 1'b0);

   task reset();
      rst <=1;
      repeat(3)@(posedge clk);
      rst <=0;
   endtask // reset

   task run();
      sim_done = 0;
      reset();

      $display("----------- SEl = 00 -----------");
      for(int i = 0; i < R; i = i+1)begin
	 sel <= 2'h0;
	 @(posedge clk);
      end

      $display("----------- SEl = 01 -----------");
      for(int i = 0; i < R; i = i+1)begin
	 sel <= 2'h1;
	 @(posedge clk);
      end
      
      $display("----------- SEl = 10 -----------");
      for(int i = 0; i < R; i = i+1)begin
	 sel <= 2'h2;
	 @(posedge clk);
      end

      $display("----------- SEl = 11 -----------");
      for(int i = 0; i < R; i = i+1)begin
	 sel <= 2'h3;
	 @(posedge clk);
      end
      
      $display("----------- Random -----------");
      for(int i = 0; i < 2*R; i = i+1)begin
	 sel <= $urandom;
	 @(posedge clk);
      end

      sim_done = 1;
      
   endtask // run

   // verification function
   function [N-1:0] univ_test (input [N-1:0] test_din, [$clog2(N)-1:0] test_sel, [N-1:0] prev_out);
      
      logic [N-1:0] test_dout;

      if(sel == 0)
	test_dout = prev_out;
      else if(sel == 1)
	test_dout = {test_din[N-1], prev_out[N-1:1]};
      else if(sel == 2)
	test_dout = {prev_out[N-2:0],test_din[0]};
      else 
	test_dout = test_din;

      return test_dout;

   endfunction // unvi_test
   
   

   // generate random input
   always_ff@(posedge clk)
     if(rst)
       din <= 0;
     else
       din <= $urandom();
   
  
   // verify the result
   always_ff@(posedge clk)begin
      if(rst)begin
	 exp_res <= 0;
      end else begin
	 exp_res <= univ_test (din,sel,exp_res);

	 //read result
	 if(exp_res == dout)
	   $display("sel = %0d, exp_res = %0d, res = %0d", sel, exp_res, dout);
	 else begin
	    $display("Simulation Fail ;(");
	    $display("sel = %0d, exp_res = %0d, res = %0d", sel, exp_res, dout);
	    $finish;
	 end
      end // else: !if(rst)
   end // always_ff@ (posedge clk)
     	 
   
   initial begin 
      run();
      if(sim_done)
	$display("Simulation Pass ;)");
      $finish;
   end
 
   initial begin 
      $dumpfile("tb_univ_shift_reg.vcd"); 
      $dumpvars(0,tb_univ_shift_reg); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
