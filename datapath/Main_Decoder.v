`timescale 1ns/1ps

module Main_Decoder(
	input  [6:0] opcode,
	output       RegWrite, ALUSrc, MemWrite, Branch, Jump,
	output [1:0] ALUOp,
	output [1:0] ImmSrc, ResultSrc
);
	reg [12:0] control_sig;
	assign {RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp,Jump} = control_sig;
	always @(opcode) begin
		case(opcode)
			7'b0110011:  control_sig = 11'b1xx00000100;  //ADD, SUB cua R type
			7'b0010011 : control_sig = 11'b10010000100; //ADDI
			7'b0000011 : control_sig = 11'b10010010000; //LW
         7'b0100011 : control_sig = 11'b00111xx0000; //SW
			7'b1100011 : control_sig = 11'b01000xx1010; //BEQ, BNE
			7'b1101111 : control_sig = 11'b111x0100xx1; //JAL
			default    : control_sig = 11'bxxxxxxxxxxx;
		endcase
	end
endmodule