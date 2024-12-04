`timescale 1ns/1ns 
module tb_shift_register(); 
   localparam t = 10;
   localparam N = 4;
   
   logic      clk; 
   logic      rst; 

   logic      din;

   logic      exp_res;
  
   logic      queue_res [$];
   logic      sim_done;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			dout;			// From DUT of shift_register.v
   // End of automatics
   
   shift_register DUT (/*AUTOINST*/
		       // Outputs
		       .dout		(dout),
		       // Inputs
		       .clk		(clk),
		       .rst		(rst),
		       .din		(din)); 
   
   always #(t/2) clk = (clk === 1'b0); 

   task reset();
      rst <= 1;
      repeat(3) @(posedge clk);
      rst <= 0;
   endtask // reset

   task run();
      sim_done = 0;
      reset();

      repeat(50) @(posedge clk);
      
      repeat((N+1)) @(posedge clk);
      
      sim_done = 1;
   endtask // run

   // generate random input
   always_ff@(posedge clk)
     if(rst)
       din <= 1'b0;
     else
       din <= $urandom();

   // verify the result
  always@(posedge clk)begin
      if(rst)begin
	 queue_res = {0,0,0,0};  
	 // Icarus Verilog does not support this => '{N{0}};
	 // Simulate in EDA Playgound with https://www.edaplayground.com/x/ZqT4 
      end else begin
	queue_res.push_front(din);
 
	exp_res = queue_res.pop_back();
	if(exp_res == dout)
	   $display("exp_res = %0d, res = %0d", exp_res, dout);
        else begin
	   $display("Simulation Fail ;(");
           $display("exp_res = %0d, res = %0d", exp_res, dout);
           $finish;
	 end
     end
   end // always@ (posedge clk)
    
      
   initial begin 
      run();
      if(sim_done)
	$display("Simulation Pass ;)");
      $finish;
   end 
   
   initial begin 
      $dumpfile("tb_shift_register.vcd"); 
      $dumpvars(0,tb_shift_register); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/shift_register" ".")
// End:
