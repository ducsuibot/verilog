// Ghép tất cả các module vào một file duy nhất
//
// File: alu_top.v
//

// Module giải mã 4-bit BCD sang 7-segment
// Giao diện cathode chung (common cathode)
module bcd_to_7seg(
    input  [3:0] bcd_input,
    output reg [6:0] seg_output
);
    always @(*) begin
        case (bcd_input)
            4'd0: seg_output = 7'b1000000; // 0
            4'd1: seg_output = 7'b1111001; // 1
            4'd2: seg_output = 7'b0100100; // 2
            4'd3: seg_output = 7'b0110000; // 3
            4'd4: seg_output = 7'b0011001; // 4
            4'd5: seg_output = 7'b0010010; // 5
            4'd6: seg_output = 7'b0000010; // 6
            4'd7: seg_output = 7'b1111000; // 7
            4'd8: seg_output = 7'b0000000; // 8
            4'd9: seg_output = 7'b0010000; // 9
            default: seg_output = 7'b1111111; // Tắt (hoặc lỗi)
        endcase
    end
endmodule

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

// Module top để kết nối và hiển thị
module top(
    input  [9:0] SW, // 10 switch
    
    // Đầu ra cho màn hình 7-segment
    output [6:0] HEX5, // A (chục)
    output [6:0] HEX4, // A (đơn vị)
    output [6:0] HEX3, // B (chục)
    output [6:0] HEX2, // B (đơn vị)
    output [6:0] HEX1, // Y (chục)
    output [6:0] HEX0  // Y (đơn vị)
);
    // Khai báo các dây nối
    wire [3:0] A_in, B_in;
    wire [1:0] OP_in;
    wire [7:0] Y_out;
    
    wire [3:0] A_unit, A_tens;
    wire [3:0] B_unit, B_tens;
    wire [3:0] Y_unit, Y_tens;

    // Gán đầu vào từ switch
    assign A_in  = SW[3:0]; // SW0-SW3 cho A
    assign B_in  = SW[7:4]; // SW4-SW7 cho B
    assign OP_in = SW[9:8]; // SW8-SW9 cho mã lệnh

    // Khởi tạo ALU
    alu alu_u (
        .A(A_in),
        .B(B_in),
        .OP(OP_in),
        .Y(Y_out)
    );

    // Tách các giá trị thành hàng chục và hàng đơn vị
    // để hiển thị thập phân
    assign A_unit = A_in % 10;
    assign A_tens = A_in / 10;
    
    assign B_unit = B_in % 10;
    assign B_tens = B_in / 10;
    
    assign Y_unit = Y_out % 10;
    assign Y_tens = Y_out / 10;

    // Khởi tạo các module giải mã BCD
    bcd_to_7seg segA_unit (
        .bcd_input(A_unit),
        .seg_output(HEX4)
    );
    bcd_to_7seg segA_tens (
        .bcd_input(A_tens),
        .seg_output(HEX5)
    );
    bcd_to_7seg segB_unit (
        .bcd_input(B_unit),
        .seg_output(HEX2)
    );
    bcd_to_7seg segB_tens (
        .bcd_input(B_tens),
        .seg_output(HEX3)
    );
    bcd_to_7seg segY_unit (
        .bcd_input(Y_unit),
        .seg_output(HEX0)
    );
    bcd_to_7seg segY_tens (
        .bcd_input(Y_tens),
        .seg_output(HEX1)
    );
endmodule