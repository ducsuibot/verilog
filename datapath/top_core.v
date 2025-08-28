`timescale 1ns/1ps

module top_core(
	input clk,rst
);
	// đường dây Fetch
	wire [31:0] PCF,instrF;
	
	// đường dây data memory
	wire [31:0] ALUResultM, ReadDataM,WriteDataM;
	
	// đường dây Control_Unit
	wire [6:0] opcode;
	wire [2:0] funct3;
	wire	funct7_6;
	wire Zero;
	wire MemWrite,ALUSrc,RegWrite,JSrc,PCSrc;
	wire [1:0] ResultSrc,ImmSrc;
	wire [2:0] ALUControl;
	
	Control_Unit myControl_Unit(.funct7_6(funct7_6),
                                .Zero(Zero),
                                .funct3(funct3),
                                .opcode(opcode),
                                .MemWrite(MemWrite),
                                .ALUSrc(ALUSrc),
                                .RegWrite(RegWrite),
                                .JSrc(JSrc),
                                .PCSrc(PCSrc),
                                .ResultSrc(ResultSrc),
                                .ImmSrc(ImmSrc),
                                .ALUControl(ALUControl)); 
										  
	Instruction_Memory myInstr_mem(.A(PCF),
                                   .RD(InstrF));

   Data_Memory myData_mem (.clk(clk),
                            .WE(MemWrite),
                            .A(ALUResultM),
                            .WD(WriteDataM),
                            .RD(ReadDataM));
									 
	Datapath myDatapath (.clk(clk),
                         .rst(rst),
                         .MemWrite(MemWrite),
                         .ALUSrc(ALUSrc),
                         .RegWrite(RegWrite),
                         .JSrc(JSrc),
                         .PCSrc(PCSrc),
                         .ResultSrc(ResultSrc),
                         .ImmSrc(ImmSrc),
                         .ALUControl(ALUControl),
                         .opcode(opcode),
                         .funct3(funct3),
                         .Zero(Zero),
                         .funct7_6(funct7_6),
                         .InstrF(InstrF),
                         .PCF(PCF),
                         .ReadDataM(ReadDataM),
                         .ALUResultM(ALUResultM),
                         .WriteDataM(WriteDataM));
endmodule

