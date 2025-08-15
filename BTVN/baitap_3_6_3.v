// posedge khi tín hiệu đi lên và negedge khi tín hiệu đi xuống
// ví dụ
// always @(posedge clk)
//		register <= register_input
module baitap_3_6_3(
	input d,
	input clk,
	input reset,
	output reg q
);
	always @(posedge clk) begin
		if(!reset) begin // nếu reset bật và cạnh clk lên
			q <= 1'b0;    // reset đồng bộ về 0
		end else begin
			q <= d;
		end
	end
endmodule