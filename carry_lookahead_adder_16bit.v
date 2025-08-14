module carry_lookahead_adder_16bit(a, b, cin, sum, cout);
    input [15:0] a, b;
    input cin;
    output [15:0] sum;
    output cout;

    // Dây nối cho các bit nhớ trung gian giữa các khối 4-bit
    wire c1, c2, c3;

    // Khối CLA 4-bit đầu tiên
    cla_4bit cla_0(
        .a(a[3:0]), 
        .b(b[3:0]), 
        .cin(cin), 
        .sum(sum[3:0]), 
        .cout(c1)
    );

    // Khối CLA 4-bit thứ hai
    cla_4bit cla_1(
        .a(a[7:4]), 
        .b(b[7:4]), 
        .cin(c1), 
        .sum(sum[7:4]), 
        .cout(c2)
    );
    
    // Khối CLA 4-bit thứ ba
    cla_4bit cla_2(
        .a(a[11:8]), 
        .b(b[11:8]), 
        .cin(c2), 
        .sum(sum[11:8]), 
        .cout(c3)
    );

    // Khối CLA 4-bit thứ tư
    cla_4bit cla_3(
        .a(a[15:12]), 
        .b(b[15:12]), 
        .cin(c3), 
        .sum(sum[15:12]), 
        .cout(cout)
    );
endmodule