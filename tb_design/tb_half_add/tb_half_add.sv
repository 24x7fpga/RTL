`timescale 1ns/1ns 
module tb_half_add(); 
   localparam t = 10; 
   logic   clk;
   logic rst;
 

   logic a, b;

   logic [1:0] result;
 
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			co;			// From DUT of half_add.v
wire			s;			// From DUT of half_add.v
// End of automatics
half_add DUT (/*AUTOINST*/
	      // Outputs
	      .s			(s),
	      .co			(co),
	      // Inputs
	      .a			(a),
	      .b			(b)); 
 
always #(t/2) clk = (clk === 1'b0); 

   always_ff @(posedge clk) begin
      if(rst)
	{a,b} <= 2'b00;
      else
	{a,b} <= $urandom_range(0,3);
   end

   // verification

   assign result = a + b;

   always_ff @(posedge clk) begin
      if(rst)begin
	$display("====================== Half Adder Simulation ===================");
      end else begin
	 if(result == {co,s})begin
	   $display("a = %0d, b = %0d :: Expected Result = %0d == Simulated Result = %0d", a, b, result, {co,s});
	 end else begin
	   $display("a = %0d, b = %0d :: Expected Result = %0d != Simulated Result = %0d\n", a, b, result, {co,s});
	   $finish;
	 end
      end
   end

   initial begin
      rst = 1;
      #20;
      rst = 0;
      #85;
      $display("Simulation PASS ;)\n");
      $finish;
   end
   
   
   initial begin 
      $dumpfile("tb_half_add.vcd"); 
      $dumpvars(0,tb_half_add); 
   end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
