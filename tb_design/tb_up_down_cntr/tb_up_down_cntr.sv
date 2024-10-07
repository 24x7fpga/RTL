`timescale 1ns/1ns 
module tb_up_down_cntr(); 
   localparam t = 10;
   localparam N = 4;
   
   logic      clk; 
   logic      rst;

   logic      up;

   logic      sim_done; 
   logic [N-1:0] exp_res;
   
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [N-1:0]		dout;			// From DUT of up_down_cntr.v
   // End of automatics
   up_down_cntr #(/*AUTOINSTPARAM*/
		  // Parameters
		  .N			(N)) DUT (/*AUTOINST*/
						  // Outputs
						  .dout			(dout[N-1:0]),
						  // Inputs
						  .up			(up),
						  .clk			(clk),
						  .rst			(rst)); 
    
   always #(t/2) clk = (clk === 1'b0);

   task reset();
      rst <= 1;
      repeat(2)@(posedge clk);
      rst <= 0;
   endtask // reset

   task run();
      sim_done = 0;
      reset();

      $display("--------------- Count UP ---------------");
      up <= 1;
      repeat(2**(N))@(posedge clk);
      
      
      $display("-------------- Count DOWN --------------");
      up <= 0; 
      repeat(2**(N))@(posedge clk);
     
 
      $display("------------ Randdom Count  ------------");
      repeat(4**(N)) begin
	 up <= $urandom();
	 @(posedge clk);
      end
      

      sim_done = 1;
   endtask; // run

   // verification function
   always_ff@(posedge clk)begin
      if(rst)
	exp_res <= 0;
ea     else begin
	 if(up)
	   exp_res <= exp_res + 1;
	 else
	   exp_res <= exp_res - 1;

	 if(exp_res == dout)
	   $display("count = %0d, exp_res = %0d, res = %0d", up, exp_res, dout);
	 else begin
	    $display("------------- Simulation Fail ;( -------------");
	    $display("count = %0d, exp_res = %0d, res = %0d", up, exp_res, dout);
	    $finish;
	 end
	   
      end
   end
   

   initial begin 
      run();
      if(sim_done)
	$display("------------- Simulation Pass ;) -------------");
      $finish;
   end 
   initial begin 
      $dumpfile("tb_up_down_cntr.vcd"); 
      $dumpvars(0,tb_up_down_cntr); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End: 
