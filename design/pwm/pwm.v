`timescale 1ns/1ns 
module pwm #(parameter n = 8)(/*AUTOARG*/
   // Outputs
   pwm,
   // Inputs
   clk, rst, duty, dvsr
   );
   input clk;
   input rst;
   input [n:0] duty;
   input [31:0]	dvsr;
   output	pwm;
  
   /*AUTOINPUT*/
   /*AUTOOUTPUT*/
   /*AUTOREG*/ 
   /*AUTOWIRE*/

   reg [n-1:0]	cnt_reg, cnt_nxt;
   reg [31:0]	t_reg, t_nxt;
   reg		pwm_reg, pwm_nxt;
   reg		tick;
   
   

   always@(posedge clk)
     begin
	if(!rst)begin
	   cnt_reg <= 'h0;
	   pwm_reg <= 'h0;
	   t_reg   <= 'h0;
	end else begin
	   cnt_reg <= cnt_nxt;
	   pwm_reg <= pwm_nxt;
	   t_reg   <= t_nxt;
	end
     end

   always@(/*AUTOSENSE*/cnt_reg or duty or dvsr or t_reg)
     begin
	if(t_reg == dvsr)
	  t_nxt = 'h0;
	else 
	  t_nxt = t_reg + 'h1;

	if (t_reg == 0)
	  tick = 1;
	else
	  tick = 0;

	if(tick)
	  cnt_nxt = cnt_reg + 1;
	else
	  cnt_nxt = cnt_reg;

	if({1'b0,cnt_reg} < duty)
	  pwm_nxt = 1;
	else
	  pwm_nxt = 0;

     end // always@ (...
   	
   assign pwm = pwm_reg;
   
endmodule 
// Local Variables: 
// verilog-library-directories: ("~/Projects/FPGA_Projects/RTL/designs/pwm" ".")
// End:
