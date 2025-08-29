`timescale 1ns/1ps

module Control_Unit(
	input funct7_6,
	input Zero,
	input [2:0] funct3,
	input [6:0] opcode,
	output MemWrite,ALUSrc,RegWrite,PCSrc,
	output [1:0] ResultSrc,
	output [1:0] ImmSrc,
	output [2:0] ALUControl
);
	wire [1:0] ALUOp;
	wire Branch,Jump,Branch_En;
	wire a1;
	
	Main_Decoder   myMain_D(.opcode(opcode),.RegWrite(RegWrite),
                            .ALUSrc(ALUSrc),.MemWrite(MemWrite),
                            .Branch(Branch),.Jump(Jump),
                            .ALUOp(ALUOp),
                            .ImmSrc(ImmSrc),.ResultSrc(ResultSrc));

	ALU_Decoder    myALU_D(.ALUOp(ALUOp),.funct3(funct3),
                           .funct7_6(funct7_6),.ALUControl(ALUControl));
									
	Branch_Decoder myBranh_D(.Zero(Zero),
                             .funct3(funct3),.Branch_En(Branch_En));
									  
	 and and1(a1, Branch_En, Branch);

	 or or1  (PCSrc, Jump, a1);

endmodule