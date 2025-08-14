// File: top.v
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
// Sử dụng module Double Dabble để chuyển đổi A, B và Y
    bin_to_bcd_4bit bcd_A_u (
        .bin_in(A_in),
        .bcd_tens(A_tens),
        .bcd_unit(A_unit)
    );
    bin_to_bcd_4bit bcd_B_u (
        .bin_in(B_in),
        .bcd_tens(B_tens),
        .bcd_unit(B_unit)
    );
    bin_to_bcd_4bit bcd_Y_u (
        .bin_in(Y_out[3:0]), // Chỉ sử dụng 4 bit thấp của Y
        .bcd_tens(Y_tens),
        .bcd_unit(Y_unit)
    );


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