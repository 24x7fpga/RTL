`timescale 1ns/1ns 
module my_tmds(/*AUTOARG*/
   // Outputs
   tmds_out,
   // Inputs
   clk, de, ctl, d_in
   );
   // Outputs
   output [9:0] tmds_out;
   // Input
   input	clk;
   input	de;
   input [1:0]	ctl;
   input [7:0]	d_in;

   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg [9:0]		tmds_out;
   // End of automatics
   /*AUTOWIRE*/

   logic [3:0]		no_ones;
   logic		cnd_xor;
   logic [8:0]		q_m;
   logic [9:0]		q_out, q_code;
   
   logic [4:0]		ones, zero;
   
   logic signed [4:0]	cnt_reg, cnt_nxt;
   logic signed [4:0]	diff_ones, diff_zero;
   
   
   // Stage 1 => 8 to 9-bits
   assign no_ones = d_in[0] + d_in[1] + d_in[2] + d_in[3] + d_in[4] + d_in[5] + d_in[6] + d_in[7];
   assign cnd_xor = (no_ones > 4) || (no_ones == 4 && d_in[0] == 0);
   assign q_m     = (cnd_xor) ? {1'b0, ~(q_m[6:0] ^ d_in[7:1]), d_in[0]} : {1'b1, (q_m[6:0] ^ d_in[7:1]), d_in[0]};
   
   // Stage 2 => 9 to 10-bits
   assign ones = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7];
   assign zero = 4'h8 - ones;
   
   
   assign cnd_1 = (cnt_reg == 0) || (ones == zero);
   assign cnd_2 = ((cnt_reg >  0) && (ones > zero)) || ((cnt_reg < 0) && (zero > ones));

   assign diff_ones = $signed(ones) - $signed(zero);
   assign diff_zero = $signed(zero) - $signed(ones);
   
		    
   always_comb begin
      if(cnd_1) begin
	 q_out      = {~q_m[8], q_m[8], ~({8{q_m[8]}} ^ q_m[7:0])};
	 cnt_nxt    = (~q_m[8]) ? (cnt_reg + diff_zero) : (cnt_reg + diff_ones);
      end else begin
	 if(cnd_2) begin
	    q_out   = {1'b1, q_m[8], ~q_m[7:0]};
	    cnt_nxt = cnt_reg + (2'b10 & {2{q_m[8]}}) + diff_zero;
	 end else begin
	    q_out   = {1'b0, q_m[8], q_m[7:0]};
	    cnt_nxt = cnt_reg - (2'b10 & {2{~q_m[8]}}) + diff_ones;
	 end
      end // else: !if(cnd_1)
   end // always_comb
  
   assign q_code = ctl[1] ? (ctl[0] ? 10'b1010101011 : 10'b0101010100) : (ctl[0] ? 10'b0010101011 : 10'b1101010100);
//    always@(*) begin
//       case(ctl)
// 	2'd0 : q_code = 10'b1101010100;
// 	2'd1 : q_code = 10'b0010101011;
// 	2'd2 : q_code = 10'b0101010100;
// 	2'd3 : q_code = 10'b1010101011;
//       endcase // case (ctl)
//    end // always_comb
   

   // Registered output and signal
   always_ff@(posedge clk) begin
      if(de) begin
	 cnt_reg  <= cnt_nxt;
	 tmds_out <= q_out;
      end else begin
	 cnt_reg  <= 5'h0;
	 tmds_out <= q_code;
      end // else: !if(de)
   end // always_ff
   
endmodule 
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
