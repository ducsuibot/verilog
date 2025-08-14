module ripple_carry_adder10 #(
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