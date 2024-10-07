`timescale 1ns/1ns 
module tb_casex_nd_casez(); 
   localparam t = 10; 
   logic      clk; 

   logic      sim_done;


   logic [3:0] sel;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [1:0]		casex_q;		// From DUT of casex_nd_casez.v
   wire [1:0]		casex_x;		// From DUT of casex_nd_casez.v
   wire [1:0]		casex_z;		// From DUT of casex_nd_casez.v
   wire [1:0]		casez_q;		// From DUT of casex_nd_casez.v
   wire [1:0]		casez_x;		// From DUT of casex_nd_casez.v
   wire [1:0]		casez_z;		// From DUT of casex_nd_casez.v
   // End of automatics

   casex_nd_casez DUT (/*AUTOINST*/
		       // Outputs
		       .casex_x		(casex_x[1:0]),
		       .casex_z		(casex_z[1:0]),
		       .casex_q		(casex_q[1:0]),
		       .casez_x		(casez_x[1:0]),
		       .casez_z		(casez_z[1:0]),
		       .casez_q		(casez_q[1:0]),
		       // Inputs
		       .sel		(sel[3:0])); 

   always #(t/2) clk = (clk === 1'b0); 


   logic [3:0]		temp_x, temp_z;
   logic [2:0]		set_x,  set_z;
   
   
   task run();
      sim_done = 0;

      $display("--------------- Simulation Start -----------------");
      repeat(20) begin
	 #(t) sel <= $urandom_range(0,15);
      end

      // generate random unknown (x) values
      repeat(30) begin
	 temp_x        <= $urandom_range(0,15);
	 set_x         <= $urandom_range(1,4);
	 temp_x[set_x] <= 'x;
	 #(t) sel      <= temp_x;
      end

      // generate random unknown (x) values
      repeat(30) begin
	 temp_z        <= $urandom_range(0,15);
	 set_z         <= $urandom_range(1,4);
	 temp_z[set_z] <= 'z;
	 #(t) sel      <= temp_z;
      end

      sim_done = 1;

   endtask // run

      
   initial begin 
      run();
      if(sim_done)
	$display("-------------- Simulation Finish -----------------");
      $finish;
   end
   
   initial begin 
      $dumpfile("tb_casex_nd_casez.vcd"); 
      $dumpvars(0,tb_casex_nd_casez); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
