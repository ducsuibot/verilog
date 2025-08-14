// =============================================================================
// Module: shift_add_multiplier
// Mô tả: Bộ nhân số nguyên 16x16 bit KHÔNG DẤU sử dụng thuật toán dịch và cộng.
// Đầu vào: a, b (số nguyên 16 bit không dấu)
// Đầu ra: product (kết quả 32 bit không dấu)
// =============================================================================
module shift_add_multiplier10( 
    input  [15:0] a,
    input  [15:0] b,
    output [31:0] product
);
    wire [31:0] partial_sums [16:0];
    assign partial_sums[0] = 32'b0;

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : multiplier_gen
            // Lấy giá trị a đã dịch trái
            wire [31:0] shifted_a = (b[i] == 1'b1) ? (a << i) : 32'b0;
            
            // Dùng bộ cộng ripple_carry_adder10 để cộng dồn
            // mỗi kết quả dịch với tổng riêng phần trước đó
            ripple_carry_adder10 #(.n(32)) u_adder (
                .a   (partial_sums[i]),
                .b   (shifted_a),
                .cin (1'b0),
                .sum (partial_sums[i+1]),
                .cout()
            );
        end
    endgenerate

    // Kết quả cuối cùng là tổng cuối cùng
    assign product = partial_sums[16];
endmodule
