`timescale 1ns/1ns 
module tb_tmds(); 
   localparam t = 10; 
   logic      clk;
   
   logic [1:0] ctl;
   logic       de;
   logic [7:0] d_in;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [9:0]		tmds_out1;		// From DUT of tmds.v
   wire [9:0]		tmds_out2;		// From DUT of tmds.v
   // End of automatics
   tmds DUT (/*AUTOINST*/
	     // Outputs
	     .tmds_out1			(tmds_out1[9:0]),
	     .tmds_out2			(tmds_out2[9:0]),
	     // Inputs
	     .clk			(clk),
	     .rst			(rst),
	     .de			(de),
	     .ctl			(ctl[1:0]),
	     .d_in			(d_in[7:0])); 
  
   always #(t/2) clk = (clk === 1'b0); 
   
   initial begin
      repeat(8)begin
	 de   = 0;
	 d_in = 0;
	 ctl  = $urandom_range(0,3);
	 #(t);
      end
      
      repeat(100) begin
	 de = 1;
	 d_in = $urandom();
	 #(t);
      end
      $finish;  
   end 
  
   always@(posedge clk) begin
      if(tmds_out1 == tmds_out2)
	$display("PASS ;) :: TMDS1 = %d, TMDS2 = %d", tmds_out1, tmds_out2);
      else
	$display("FAIL ;) :: TMDS1 = %d, TMDS2 = %d", tmds_out1, tmds_out2);
   end
   
	
   initial begin 
      $dumpfile("tb_tmds.vcd"); 
      $dumpvars(0,tb_tmds); 
   end 

endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
