module cla_4bit(a, b, cin, sum, cout);
    input [3:0] a, b;
    input cin;
    output [3:0] sum;
    output cout;
    
    wire [3:0] p, g;
    wire [3:0] c;

    // Tính toán tín hiệu propagate (p) và generate (g) cho mỗi bit
    // p[i] = a[i] XOR b[i]
    // g[i] = a[i] AND b[i]
    assign p = a ^ b;
    assign g = a & b;

    // Tính toán các bit nhớ (c) một cách song song
    // c[i] = g[i] OR (p[i] AND c[i-1])
    assign c[0] = g[0] | (p[0] & cin);
    assign c[1] = g[1] | (p[1] & c[0]);
    assign c[2] = g[2] | (p[2] & c[1]);
    assign c[3] = g[3] | (p[3] & c[2]);

    // Tính toán các bit tổng (sum)
    // sum[i] = p[i] XOR c[i-1]
    assign sum[0] = p[0] ^ cin;
    assign sum[1] = p[1] ^ c[0];
    assign sum[2] = p[2] ^ c[1];
    assign sum[3] = p[3] ^ c[2];

    // Ngõ ra carry cuối cùng
    assign cout = c[3];
endmodule