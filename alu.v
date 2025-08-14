// File: alu.v
// Module ALU 4-bit

module alu(
    input  [3:0] A,
    input  [3:0] B,
    input  [1:0] OP,
    output reg [7:0] Y 
);
    always @(A, B, OP) begin
        case (OP)
            2'b00: Y = A + B;       // Cộng
            2'b01: Y = A - B;       // Trừ
            2'b10: Y = ~A;          // NOT
            2'b11: Y = A & B;       // AND
            default: Y = 8'd0;      // Mặc định
        endcase
    end
endmodule