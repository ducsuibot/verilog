// 3.6.7 kết hợp logic tổ hợp trong khối always mạch dãy 
module baitap_3_6_7(up,down,cnt,rst_n,clk);
	input up,down;
	input clk,rst_n;
	output reg [7:0] cnt;
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt <= 0;
		end else if(up) begin
			cnt <= cnt +1;
		end else if(down) begin
			cnt <= cnt -1;
		end else begin
			cnt <= cnt;
		end
	end
endmodule