`timescale 1ns/1ps

module Mux2_1(
	input [31:0] n0,
	input [31:0] n1,
	input sel,
	output [31:0] out
);
	assign out = (sel == 0)? n0 : n1;
endmodule