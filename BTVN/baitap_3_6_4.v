// 3.6.5
module baitap_3_6_4(
	input d,
	input clk,
	input reset,
	output reg q
);
	always @(posedge clk or negedge reset) begin
		if(!reset) begin
			q <= 1'b0;
		end else begin
			q <= d;
		end
	end
endmodule