`timescale 1ns/1ns 

`include "comp.svh"
module tb_comparator(); 
   localparam t = 10; 
   localparam n = 4;

   logic [n-1:0] a, b;
   logic [2:0]	 res;

   logic [2:0]	 exp_res;
   
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire		 et;			// From DUT of comparator.v
   wire		 gt;			// From DUT of comparator.v
   wire		 lt;			// From DUT of comparator.v
   // End of automatics
   comparator DUT (/*AUTOINST*/
		   // Outputs
		   .gt			(gt),
		   .lt			(lt),
		   .et			(et),
		   // Inputs
		   .a			(a[n-1:0]),
		   .b			(b[n-1:0])); 

   string st_et = "A is EQUAL to B";
   string st_gt = "A is GREATER THAN B";
   string st_lt = "A is LESS THAN B";
   string st_na = "N/A";
   string st_disp;
   
   initial begin
      repeat(30)begin
	 a = $urandom_range(1,2**(n));
	 b = $urandom_range(1,2**(n));
	 #t;
	 exp_res = comp(a,b);
	 res     = {et,gt,lt};
	 
	 if(res == 4)
	   st_disp = st_et;
	 else if(res == 2)
	   st_disp = st_gt;
	 else if(res == 1)
	   st_disp = st_lt;
	 else
	   st_disp = st_na;
	 
	// st_disp = (res != 4) ? (res != 2) ?  (res != 1) ? st_na : st_lt : st_gt : st_et; 
	 if(exp_res == res)
	   $display(" a=%0d, b=%0d, result= %s", a, b, st_disp);
	 else begin
           $display(" Simulation FAIL ;(");
	   $display(" a=%0d, b=%0d", a, b);
	   $display(" exp_et=%0d, et=%0d", exp_res[2], et);
	   $display(" exp_gt=%0d, gt=%0d", exp_res[1], gt);
	   $display(" exp_lt=%0d, lt=%0d", exp_res[0], lt);
	 end
      end
      $display(" Simulation PASS ;)");
   end 
   initial begin 
      $dumpfile("tb_comparator.vcd"); 
      $dumpvars(0,tb_comparator); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/comparator" ".")
// End: 
