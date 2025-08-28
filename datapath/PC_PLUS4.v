`timescale 1ns/ 1ps

module PC_PLUS4(
	input [31:0] PC,
	output [31:0] PC_plus4
);
	assign PC_plus4 = PC + 4;
endmodule