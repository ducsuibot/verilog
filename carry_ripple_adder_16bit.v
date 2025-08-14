module carry_ripple_adder_16bit(A, B, S, COUT);
    input [15:0] A, B;
    output [15:0] S;
    output COUT;
    
    wire [14:0] C;
    
    // Instance đầu tiên là half_adder cho bit 0
    half_adder ha0(A[0], B[0], S[0], C[0]);
    
    genvar i;
    generate
        for (i = 1; i < 15; i = i + 1) begin : fa_loop // Thêm tên cho khối generate
            full_adder fa_i(A[i], B[i], C[i-1], S[i], C[i]);
        end
    endgenerate
    
    // Instance cuối cùng có ngõ ra carry là COUT
    full_adder fa15(A[15], B[15], C[14], S[15], COUT);
    
endmodule