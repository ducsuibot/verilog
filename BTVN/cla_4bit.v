module cla_4bit(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
);
    // Propagate and Generate signals
    wire [3:0] p, g;

    // Calculate P and G for each bit
    assign p = a ^ b;
    assign g = a & b;

    // Calculate carry signals
    wire c1, c2, c3;
    assign c1 = g[0] | (p[0] & cin);
    assign c2 = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c3 = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);

    // Calculate sum bits in parallel
    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ c1;
    assign sum[2] = p[2] ^ c2;
    assign sum[3] = p[3] ^ c3;

    // Final carry-out
    assign cout = g[3] | (p[3] & c3);
endmodule 

// Kích thước (Size/LEs): CLA nhìn chung lớn hơn CRA vì nó yêu cầu logic tổ hợp phức tạp  
// Độ trễ (Delay): CLA nhanh hơn đáng kể so với CRA. On vs Ologn