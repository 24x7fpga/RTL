//                   FLOW CONTROL REGISTER
// Reference: Digital Design: A System Approach by Dally and Harting
//            Example: 22.1 

`timescale 1ns/1ns 
module flow_ctrl_reg #(parameter N = 4) (/*AUTOARG*/
   // Outputs
   valid_out, ready_out, d_out,
   // Inputs
   clk, rst, valid_in, ready_in, d_in
   ); 
   input logic clk; 
   input logic rst;
   input logic valid_in;
   input logic ready_in;
   input logic [N-1:0] d_in;

   output logic        valid_out;
   output logic        ready_out;
   output logic [N-1:0] d_out;


   logic 		en;
  
   logic 		valid_reg, valid_nxt;
   
   /*AUTOREG*/ 
   /*AUTOWIRE*/ 
 
   // data output
   always_ff@(posedge clk)
     if(rst)
       d_out <= 0;
     else
       if(en)
	 d_out <= d_in;

   // valid out condition 
   always_ff@(posedge clk)
     if(rst)
       valid_reg <= 0;
     else
       valid_reg <= valid_nxt;

   assign valid_nxt = (valid_reg) ? ~ready_in : valid_in;


   assign en = ~valid_reg;

   assign valid_out = valid_reg;

   assign ready_out = ~valid_reg;
   
endmodule 
// Local Variables: 
// verilog-library-directories:("~/Projects/fpgaProjects/iVerilog/design/*") 
// End:
