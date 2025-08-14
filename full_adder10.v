// =============================================================================
// Module: full_adder
// Mô tả: Module cộng toàn phần 1 bit.
// Đầu vào: a, b, cin
// Đầu ra: sum, cout
// =============================================================================
module full_adder10 (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule