`timescale 1ns/1ps

module Branch_Decoder(
	input [2:0] funct3,
	input Zero,
	output reg Branch_En
);

	always @(funct3) begin
		case(funct3)
			3'b000: Branch_En = Zero;	// beq
			3'b001: Branch_En = ~Zero;	// bne
		endcase
	end
endmodule