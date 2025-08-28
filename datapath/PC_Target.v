`timescale 1ns/ 1ps

module PC_Target(
	input [31:0] PC,
	input [31:0] ImmExt,
	output [31:0] PC_Target
);
	assign PC_Target = PC + PC_Target;
endmodule
