// 3.6.3
module baitap_3_6_5(
	input d,
	input clk,
	output reg q
);
	always @(posedge clk) begin
		q <= d;
	end
endmodule