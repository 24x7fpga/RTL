`timescale 1ns/1ns
module tmds_encoder(
	input clk,
	input [7:0] d_in,  // video data (red, green or blue)
	input [1:0] ctl,  // control data
	input de,  // video data enable, to choose between ctl (when de=0) and d_in (when de=1)
	output reg [9:0] tmds_out
);

wire [3:0] Nb1s = d_in[0] + d_in[1] + d_in[2] + d_in[3] + d_in[4] + d_in[5] + d_in[6] + d_in[7];
wire XNOR = (Nb1s>4'd4) || (Nb1s==4'd4 && d_in[0]==1'b0);
wire [8:0] q_m = {~XNOR, q_m[6:0] ^ d_in[7:1] ^ {7{XNOR}}, d_in[0]};

reg [3:0] balance_acc = 0;

wire [3:0] balance = q_m[0] + q_m[1] + q_m[2] + q_m[3] + q_m[4] + q_m[5] + q_m[6] + q_m[7] - 4'd4;

wire balance_sign_eq = (balance[3] == balance_acc[3]);

wire invert_q_m = (balance==0 || balance_acc==0) ? ~q_m[8] : balance_sign_eq;

wire [3:0] balance_acc_inc = balance - ({q_m[8] ^ ~balance_sign_eq} & ~(balance==0 || balance_acc==0));

wire [3:0] balance_acc_new = invert_q_m ? balance_acc-balance_acc_inc : balance_acc+balance_acc_inc;

wire [9:0] tmds_data = {invert_q_m, q_m[8], q_m[7:0] ^ {8{invert_q_m}}};

wire [9:0] tmds_code = ctl[1] ? (ctl[0] ? 10'b1010101011 : 10'b0101010100) : (ctl[0] ? 10'b0010101011 : 10'b1101010100);


always @(posedge clk) tmds_out <= de ? tmds_data : tmds_code;
always @(posedge clk) balance_acc <= de ? balance_acc_new : 4'h0;
endmodule
// Local Variables: 
// Verilog-Library-Directories: (".")
// End:
