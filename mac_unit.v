// =============================================================================
// Module: full_adder
// Mô tả: Module cộng toàn phần 1 bit.
// Đầu vào: a, b, cin
// Đầu ra: sum, cout
// =============================================================================
module full_adder(
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

// =============================================================================
// Module: ripple_carry_adder
// Mô tả: Bộ cộng ripple-carry n bit, được xây dựng từ các full adder.
// =============================================================================
module ripple_carry_adder #(
    parameter n = 32
)(
    input  [n-1:0] a,
    input  [n-1:0] b,
    input          cin,
    output [n-1:0] sum,
    output         cout
);
    wire [n:0] c;
    assign c[0] = cin;

    // Tạo các full adder bằng vòng lặp generate
    genvar i;
    generate
        for (i = 0; i < n; i = i + 1) begin : adder_gen
            full_adder fa_inst (
                .a(a[i]),
                .b(b[i]),
                .cin(c[i]),
                .sum(sum[i]),
                .cout(c[i+1])
            );
        end
    endgenerate

    assign cout = c[n];
endmodule

// =============================================================================
// Module: shift_add_multiplier
// Mô tả: Bộ nhân số nguyên 16x16 bit sử dụng thuật toán dịch và cộng.
// Đầu vào: a, b (số nguyên 16 bit có dấu)
// Đầu ra: product (kết quả 32 bit có dấu)
// =============================================================================
module shift_add_multiplier(
    input  [15:0] a,
    input  [15:0] b,
    output [31:0] product
);
    // Xử lý dấu
    wire a_sign = a[15];
    wire b_sign = b[15];
    wire result_sign = a_sign ^ b_sign;
    
    // Lấy giá trị tuyệt đối cho phép nhân
    wire [15:0] a_abs = a_sign ? -a : a;
    wire [15:0] b_abs = b_sign ? -b : b;
    
    // Sử dụng thuật toán dịch và cộng
    reg [31:0] partial_product;
    integer i;

    // Phép nhân thực hiện trong một khối always combinational
    always @(*) begin
        partial_product = 32'b0;
        for (i = 0; i < 16; i = i + 1) begin
            if (b_abs[i] == 1'b1) begin
                partial_product = partial_product + (a_abs << i);
            end
        end
    end

    // Gán kết quả cuối cùng, xử lý lại dấu nếu cần
    assign product = result_sign ? -partial_product : partial_product;
endmodule

// =============================================================================
// Module: mac_unit
// Mô tả: Module Multiply-Accumulate cho số nguyên 16 bit.
// mac_out = in_a * in_b + in_c
// =============================================================================
module mac_unit(
    input  [15:0] in_a,
    input  [15:0] in_b,
    input  [15:0] in_c,
    output [31:0] mac_out
);
    wire [31:0] mul_out;
    wire [31:0] in_c_ext;

    // Khởi tạo bộ nhân
    shift_add_multiplier u_mul (
        .a      (in_a),
        .b      (in_b),
        .product(mul_out)
    );

    // Mở rộng bit cho in_c để phù hợp với phép cộng 32-bit
    assign in_c_ext = {{16{in_c[15]}}, in_c};

    // Khởi tạo bộ cộng (sử dụng ripple_carry_adder)
    ripple_carry_adder u_add (
        .a   (mul_out),
        .b   (in_c_ext),
        .cin (1'b0),
        .sum (mac_out)
    );
endmodule

// =============================================================================
// Module: mac_top
// Mô tả: Module top để kiểm tra chức năng của mac_unit.
// =============================================================================
module mac_top(
    input  [15:0] in_a,
    input  [15:0] in_b,
    input  [15:0] in_c,
    output [31:0] mac_out
);
    // Khởi tạo module MAC
    mac_unit u_mac (
        .in_a   (in_a),
        .in_b   (in_b),
        .in_c   (in_c),
        .mac_out(mac_out)
    );
endmodule
