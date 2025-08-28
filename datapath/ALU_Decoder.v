`timescale 1ns / 1ps

module ALU_Decoder(
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input        funct7_6, // bit 6 của funct7
    output [3:0] ALUControl
);
    reg [3:0] tempALUControl;
    assign ALUControl = tempALUControl;
    
    always @(ALUOp) begin
        case (ALUOp) 
            2'b00 : tempALUControl = 3'b000; //LW,SW -> ADD 
            2'b01 : tempALUControl = 3'b001; //BEQ. BNE, BLT, BGE -> SUB
            2'b10 : begin
                case(funct3) 
                    3'b000 : tempALUControl = (funct7_6 === 1'bx || !funct7_6) ? 4'b000 : 4'b001; // ADDI or ADD or SUB                   
                    default: tempALUControl = 4'bxxxx;
                endcase
            end
            default : tempALUControl = 3'bxxx; 
        endcase
    end

endmodule
