`timescale 1ns/1ps

module Main_Decoder(
	input  [6:0] opcode,
	output       RegWrite, ALUSrc, MemWrite, Branch, Jump, JSrc,
	output [1:0] ALUOp,
	output [1:0] ImmSrc, ResultSrc
);
	reg [12:0] control_sig;
	assign {RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp,Jump,JSrc} = control_sig;
	always @(opcode) begin
		case(opcode)
			7'b0110011:  control_sig = 12'b1xx00000100x;  //ADD, SUB cua R type
			7'b0010011 : control_sig = 12'b10010000100x; //ADDI
			7'b0000011 : control_sig = 12'b10010010000x; //LW
         7'b0100011 : control_sig = 12'b00111xx0000x; //SW
			7'b1100011 : control_sig = 12'b01000xx10100; //BEQ, BNE
			7'b1101111 : control_sig = 12'b111x0100xx10; //JAL
			default    : control_sig = 12'bxxxxxxxxxxxx;
		endcase
	end
endmodule