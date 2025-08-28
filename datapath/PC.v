`timescale 1ns/ 1ps 

module PC(
	input clk,rst,
	input [31:0] PCNext,
	output reg [31:0] PC
);
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			PC <= 32'd0;
		end else begin
			PC <= PCNext;
		end
	end
endmodule