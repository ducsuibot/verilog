// bộ đếm vòng
module baitap_6_1_2(cnt,enable,clk,reset); 
	input enable, reset, clk;
	output reg [7:0] cnt;
	always @(posedge clk or negedge reset) begin
		if(!reset) begin
			cnt <= 8'b0000_0001;
		end else if(enable == 1'b1) begin
			cnt <= {cnt[6:0],cnt[7]};
		end
	end
endmodule
// ví dụ cnt đang là 0000_0001, sau một chu kỳ xung nhịp nó sẽ trở thành 0000_0010