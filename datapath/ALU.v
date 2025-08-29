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
			3'b010: ALUResult = SrcA & SrcB;                                     // AND
         3'b011: ALUResult = SrcA | SrcB;                                     // OR
         3'b100: ALUResult = SrcA ^ SrcB;                                     // XOR
         3'b101: ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 32'b1 : 32'b0; // SLT 
         3'b110: ALUResult = (SrcA < SrcB) ? 32'b1 : 32'b0;                   // SLTU 
         3'b111: ALUResult = SrcA << SrcB[4:0];                               // SLL 

			default: ALUResult = 32'bx;
		endcase
	end
	
	assign Zero = (ALUResult == 0);
	
endmodule