// =============================================================================
// Module: mac_unit
// Mô tả: Module Multiply-Accumulate cho số nguyên 16 bit.
// mac_out = in_a * in_b + in_c
// =============================================================================
module mac_unit10(
    input  [15:0] in_a,
    input  [15:0] in_b,
    input  [15:0] in_c,
    output [31:0] mac_out
);
    wire [31:0] mul_out;
    wire [31:0] in_c_ext;

    // Khởi tạo bộ nhân
    shift_add_multiplier10 u_mul (
        .a      (in_a),
        .b      (in_b),
        .product(mul_out)
    );

    // Mở rộng bit cho in_c để phù hợp với phép cộng 32-bit
    assign in_c_ext = {16'b0, in_c};
    // Khởi tạo bộ cộng (sử dụng ripple_carry_adder)
    ripple_carry_adder10 u_add (
        .a   (mul_out),
        .b   (in_c_ext),
        .cin (1'b0),
        .sum (mac_out)
    );
endmodule
