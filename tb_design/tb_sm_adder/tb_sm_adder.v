module tb_sm_adder(); 
   parameter n = 4;
   
/*AUTOREG*/ 
/*AUTOWIRE*/ 
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire [n-1:0]		res;			// From DUT of sm_adder.v
// End of automatics
reg [n-1:0] opA; 
reg [n-1:0] opB;
   reg [n-1:0] temp;
   
sm_adder #(.n(n)) DUT (/*AUTOINST*/
	      // Outputs
	      .res			(res[n-1:0]),
	      // Inputs
	      .opA			(opA[n-1:0]),
	      .opB			(opB[n-1:0])); 
initial begin 
$dumpfile("tb_sm_adder.vcd"); 
$dumpvars(0,tb_sm_adder); 
end

initial begin
   opA = 4'b1111;
   opB = 4'b0110;
   #10;
   $finish;   
end
  initial begin
     temp = opB[n-2:0]-opA[n-2:0];
  end // UNMATCHED !!
   
endmodule 
// Local Variables: 
// verilog-library-directories:("/home/kiran/FPGA_Projects/iVerilog/design/sm_adder") 
// End:
