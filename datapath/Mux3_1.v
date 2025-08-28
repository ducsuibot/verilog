`timescale 1ns/1ps

module Mux3_1(
	input [31:0] in0,in1,in2,
	input [1:0] sel,
	output reg [31:0] out
);

	always @(sel) begin
		case(sel) 
			3'b00: out = in0;
			3'b01: out = in1;
			3'b10: out = in2;
			default: out = 32'bx;
		endcase
	end
endmodule
	