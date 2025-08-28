`timescale 1ns / 1ps 

module Datapath(
input        clk, rst,
//Control Unit
input        MemWrite, ALUSrc, RegWrite, JSrc, PCSrc,
input  [1:0] ResultSrc, ImmSrc,
input  [2:0] ALUControl,
output [6:0] opcode,
output [2:0] funct3,
output       Zero,
output       funct7_6,
//Instruction mem
input  [31:0] InstrF,
output [31:0] PCF,
//Data mem 
input  [31:0] ReadDataM,
output [31:0] ALUResultM,
output [31:0] WriteDataM

);

    //PC 
    wire [31:0] PC, PCNext;
    assign PCF = PC;
    
    PC myPC(.clk(clk),
            .rst(rst),
            .PC(PC),
            .PCNext(PCNext));
    
    //Intruction
    wire [4:0] rs1, rs2, rd;
    assign rs1      = InstrF[19:15];
    assign rs2      = InstrF[24:20];
    assign rd       = InstrF[11:7];
    assign opcode   = InstrF[6:0];
    assign funct7_6 = InstrF[30];
    assign funct3   = InstrF[14:12];
    
    //Register File
    wire [31:0] RD1, RD2;
    wire [31:0] WD3;
    Register_File myReg(.clk(clk),
                        .WE3(RegWrite),
                        .WD3(WD3),
                        .A1(rs1),
                        .A2(rs2),
                        .A3(rd),
                        .RD1(RD1),
                        .RD2(RD2));
    assign WriteDataM = RD2;
    
    //Extend
    wire [31:0] ImmExt;
    
    Extend myExtend(.Instr(InstrF[31:7]),
                    .ImmSrc(ImmSrc),
                    .ImmExt(ImmExt));
    
    // ALU Mux 
    wire [31:0] SrcB;
    
    Mux2_1 myALUMux(.n0(RD2),
                    .n1(ImmExt),
                    .sel(ALUSrc),
                    .out(SrcB));
    // ALU
    wire [31:0] ALUResult;
    
    ALU myALU(.ALUControl(ALUControl),
              .SrcA(RD1),
              .SrcB(SrcB),
              .ALUResult(ALUResult),
              .Zero(Zero));
    
    assign ALUResultM = ALUResult;
    
    //PC_Plus4 
    wire [31:0] PC_plus4;
    PC_PLUS4 myPlus4(.PC(PC),
                     .PC_plus4(PC_plus4));
    
    // PC_Target
    wire [31:0] PC_Target;  
    wire [31:0] Target_Src;
    PC_Target myTarget(.PC(Target_Src),
                       .ImmExt(ImmExt),
                       .PC_Target(PC_Target));
    // PC Mux 
    Mux2_1 myPCMux(.n0(PC_plus4),
                   .n1(PC_Target),
                   .sel(PCSrc),
                   .out(PCNext));
    // J Mux
    Mux2_1 myJMUx(.n0(PC),
                  .n1(RD1),
                  .sel(JSrc),
                  .out(Target_Src));
    //Result Mux
    Mux3_1 myResultMux (.in0(ALUResult),
                        .in1(ReadDataM),
                        .in2(PC_plus4),
                        .sel(ResultSrc),
                        .out(WD3));
                             
endmodule
