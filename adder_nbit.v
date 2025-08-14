module adder_nbit #(
    parameter WIDTH = 32
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output wire [WIDTH-1:0] sum
);
    wire [WIDTH:0] carry;
    assign carry[0] = 1'b0;

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : adder_bits
            full_adder fa (
                .A(a[i]),
                .B(b[i]),
                .CIN(carry[i]),
                .S(sum[i]),
                .COUT(carry[i+1])
            );
        end
    endgenerate
endmodule
