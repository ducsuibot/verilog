module baitap_3_5_3(
	input [15:0] src1,
	input [15:0] src2,
	input c_in,
	output [31:0] sum,
	output c_out
);
	assign {c_out,sum} = src1 + src2 + c_in;
endmodule
	