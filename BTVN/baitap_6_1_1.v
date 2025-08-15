// Bộ đếm
module baitap_6_1_1(clk,rst_n,en,cnt);
	input clk,rst_n,en;
	output reg [7:0] cnt;
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin 
			cnt <= 8'h00;
		end else if(en) begin
			cnt <= cnt + 1;
		end else begin 
			cnt <= cnt;
		end
	end
endmodule