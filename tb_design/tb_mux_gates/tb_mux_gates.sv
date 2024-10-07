`define CLK_PERIOD 10

`timescale 1ns/1ns 
module tb_mux_gates(); 

   logic clk;
   
   logic a, b; 

   logic inv_g, and_g, or_g, nand_g, nor_g, xor_g, xnor_g;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/
 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			t;			// From DUT of mux_gates.v
   wire			u;			// From DUT of mux_gates.v
   wire			v;			// From DUT of mux_gates.v
   wire			w;			// From DUT of mux_gates.v
   wire			x;			// From DUT of mux_gates.v
   wire			y;			// From DUT of mux_gates.v
   wire			z;			// From DUT of mux_gates.v
   // End of automatics
   mux_gates DUT (/*AUTOINST*/
		  // Outputs
		  .t			(t),
		  .u			(u),
		  .v			(v),
		  .w			(w),
		  .x			(x),
		  .y			(y),
		  .z			(z),
		  // Inputs
		  .a			(a),
		  .b			(b));
 
   initial clk = 1'b0;
   always #(`CLK_PERIOD/2) clk = (clk === 1'b0);
   
   always_ff@(posedge clk) begin
	 {a,b} <= $urandom();
   end

   // design test
   always_comb begin
      inv_g = ~a;
      and_g = a & b;
      or_g  = a | b;
      nand_g= ~(a & b);
      nor_g = ~(a | b);
      xor_g = a ^ b;
      xnor_g= ~(a ^ b);
   end
   
   always_ff@(negedge clk) begin
      if ( {inv_g,and_g,or_g,nand_g,nor_g,xor_g,xnor_g} == {t,u,v,w,x,y,z} )
	$display("Design PASS ;) \n");
      else 
	$display("Design Fail ;( \n Exp_Result = %0b and Sim_Result = %0b \n", {inv_g,and_g,or_g,nand_g,nor_g,xor_g,xnor_g} , {t,u,v,w,x,y,z} );
   end
   
   // run simulation
   initial begin
      #(20* `CLK_PERIOD);
      $finish;
   end
   
   initial begin 
      $dumpfile("tb_mux_gates.vcd"); 
      $dumpvars(0,tb_mux_gates); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
