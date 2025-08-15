// 3.6.6 Mô tả ff với reset đồng bộ / ko đồng bộ và tín hiệu enable
module baitap_3_6_6(
	input q_in,
	input clk,
	input reset,
	input enable,
	output reg data
);
	always @(posedge clk) begin
		if(reset) begin
			data <= 0 ;
		end else if(enable) begin
			data <= q_in;
		end
	end
endmodule