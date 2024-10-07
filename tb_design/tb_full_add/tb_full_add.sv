`timescale 1ns/1ns 
module tb_full_add(); 
   localparam t = 10; 
   logic      clk; 
   logic      rst;

   logic      a, b, c;

   logic [1:0] result;
   
   
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire			co;			// From DUT of full_add.v
wire			s;			// From DUT of full_add.v
// End of automatics
full_add DUT (/*AUTOINST*/
	      // Outputs
	      .s			(s),
	      .co			(co),
	      // Inputs
	      .a			(a),
	      .b			(b),
	      .c			(c)); 



always #(t/2) clk = (clk === 1'b0); 

   always_ff @(posedge clk) begin
      if(rst)
	{a,b,c} <= 3'b00;
      else
	{a,b,c} <= $urandom_range(0,7);
   end

   // verification

   assign result = a + b + c;

   always_ff @(posedge clk) begin
      if(rst)begin
	$display("====================== Half Adder Simulation ===================");
      end else begin
	 if(result == {co,s})begin
	   $display("a = %0d, b = %0d, c = %0d :: Expected Result = %0d == Simulated Result = %0d", a, b, c, result, {co,s});
	 end else begin
	   $display("a = %0d, b = %0d, c = %0d :: Expected Result = %0d != Simulated Result = %0d\n", a, b, c, result, {co,s});
	   $finish;
	 end
      end
   end

   initial begin
      rst = 1;
      #20;
      rst = 0;
      #185;
      $display("Simulation PASS ;)\n");
      $finish;
   end
   


initial begin 
$dumpfile("tb_full_add.vcd"); 
$dumpvars(0,tb_full_add); 
end 
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End:
