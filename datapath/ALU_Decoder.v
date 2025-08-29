`timescale 1ns / 1ps

module ALU_Decoder(
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input        funct7_6, // bit 6 của funct7
    output reg [2:0] ALUControl
);
// ALUControl mã hóa:
// 000: ADD
// 001: SUB
// 010: AND
// 011: OR
// 100: XOR
// 101: SLT (signed)
// 110: SLTU (unsigned)
// 111: SLL

    
    always @(*) begin
        case (ALUOp) 
            2'b00 : ALUControl = 3'b000; //LW,SW -> ADD 
            2'b01 : ALUControl = 3'b001; //BEQ. BNE, BLT, BGE -> SUB
            2'b10 : begin
                case(funct3) 
                    3'b000 : ALUControl = (funct7_6 === 1'bx || !funct7_6) ? 3'b000 : 3'b001; // ADDI or ADD or SUB
                    3'b001 : ALUControl = 3'b111;                                              //SLL
                    3'b010 : ALUControl = 3'b101;                                              //SLT
                    3'b011 : ALUControl = 3'b110;                                              //SLTU
                    3'b100 : ALUControl = 3'b100;                                              //XOR
                    3'b110 : ALUControl = 3'b011;                                              //OR
                    3'b111 : ALUControl = 3'b010;                                              //AND
                    
                    default: ALUControl = 3'bxxx;
                endcase
            end
            default : ALUControl = 3'bxxx; 
        endcase
    end

endmodule
