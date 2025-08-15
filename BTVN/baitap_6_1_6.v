// 6.1.6 
module baitap_6_1_6 #(parameter SIZE = 8)(
	input [SIZE-1:0] d,
	output reg [SIZE-1:0] q,
	input clk,
	input reset
);
	always @(posedge clk or negedge reset) begin
		if(!reset) begin
			q <= 0;
		end else begin
			q <= d;
		end
	end
endmodule