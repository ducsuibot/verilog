`timescale 1ns/1ps

module ALU(
	input [2:0] ALUControl,
	input [31:0] SrcA,SrcB,
	output reg [31:0] ALUResult,
	output Zero
);
	
	always @(ALUControl) begin
		case(ALUControl) 
			3'b000: ALUResult = SrcA + SrcB;
			3'b001: ALUResult = SrcA - SrcB;
			default: ALUResult = 32'bx;
		endcase
	end
	
	assign Zero = (ALUResult == 0);
	
endmodule