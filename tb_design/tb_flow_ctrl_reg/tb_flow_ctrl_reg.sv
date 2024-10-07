`timescale 1ns/1ns 
module tb_flow_ctrl_reg(); 
   localparam t = 10; 
   logic clk; 
   logic rst; 
 
   localparam N = 4;
   logic valid_in;
   logic ready_in;
   logic [N-1:0] d_in;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   logic [N-1:0]	d_out;			// From DUT of flow_ctrl_reg.v
   logic		ready_out;		// From DUT of flow_ctrl_reg.v
   logic		valid_out;		// From DUT of flow_ctrl_reg.v
   // End of automatics
  
   flow_ctrl_reg #(/*AUTOINSTPARAM*/
		   // Parameters
		   .N			(N)) DUT (/*AUTOINST*/
						  // Outputs
						  .valid_out		(valid_out),
						  .ready_out		(ready_out),
						  .d_out		(d_out[N-1:0]),
						  // Inputs
						  .clk			(clk),
						  .rst			(rst),
						  .valid_in		(valid_in),
						  .ready_in		(ready_in),
						  .d_in			(d_in[N-1:0])); 
   
   initial clk = 1; 
   always #(t/2) clk = ~clk; 
   
   initial begin 
      rst = 1; 
      #(2*t); 
      rst = 0; 
   end

   /*
   always@(posedge clk)begin
      valid_in = 1;
      if(valid_out)begin
	ready_in = 1;
        d_in = $urandom();
      end else begin
	ready_in = 0;
      end  
   end
   */

   always@(posedge clk)begin
     if(rst)begin
	d_in <= 0;
     end else begin
	if(valid_in==1 && ready_out==1)
	  d_in <= $urandom();
	else
	  d_in <= d_in;
     end
   end

   initial begin
      valid_in = 0;
      ready_in = 0;
      
      wait(rst==0);
      @(posedge clk) valid_in = 1;
      wait(valid_out==1);
      @(posedge clk) ready_in = 1;
     
      #(8*t);

      @(posedge clk) ready_in = 0;
      #(3*t);
      wait(valid_out==1);
      @(posedge clk) ready_in = 1;
     
      #(4*t);
      
      $finish;
   end // initial begin
  
   initial begin 
      $dumpfile("tb_flow_ctrl_reg.vcd"); 
      $dumpvars(0,tb_flow_ctrl_reg); 
   end 

endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/FPGA_Projects/iVerilog/design/*") 
// End: 
