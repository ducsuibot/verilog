// 6.1.3 bộ quay
module baitap_6_1_3(out,data,enable,load,clk,reset); 
	input [7:0] data; // Đầu vào dữ liệu 8-bit.
	input enable; // Tín hiệu cho phép hoạt động quay
	input clk;
	input reset; // negedge reset
	input load; // Tín hiệu cho phép nạp dữ liệu từ data vào out
	output reg [7:0] out;
	
	always @(posedge clk or negedge reset) begin
		if(!reset) begin
			out <= 8'b0;
		end else if(load) begin
			out <= data;
		end else if(enable) begin
			out <= {out[6:0],out[7]};
		end else begin
			out <= out;
		end
	end
endmodule
			