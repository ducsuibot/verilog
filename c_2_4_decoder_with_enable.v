module c_2_4_decoder_with_enable(A,E_n,D); 
input [1:0] A;
input E_n; 	//E_n là chân điều khiển tích cực mức thấp
output [3:0] D; 
assign D = {4{~E_n}}&((A == 2'b00)? 4'b0001:(A == 2'b01)? 4'b0010:(A == 2'b10)? 4'b0100:(A == 2'b11)? 4'b1000: 4'bxxxx); 
// {4{~E_n}}: Đây là toán tử nối (concatenation). Nó tạo ra một vector 4 bit có giá trị giống với ~E_n
endmodule