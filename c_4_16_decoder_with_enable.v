module C_4_16_decoder_with_enable(A, E_n, D);
    input [3:0] A;
    input E_n;
    output [15:0] D; 
	 wire [3:0] S;
	 wire [3:0] S_n;
	 c_2_4_decoder_with_enable DE (A[3:2], E_n, S);
	 not N0 (S_n, S);
	 c_2_4_decoder_with_enable D0 (A[1:0], S_n[0], D[3:0]);
	 c_2_4_decoder_with_enable D1 (A[1:0], S_n[1], D[7:4]);
    c_2_4_decoder_with_enable D2 (A[1:0], S_n[2], D[11:8]);
    c_2_4_decoder_with_enable D3 (A[1:0], S_n[3], D[15:12]);
endmodule