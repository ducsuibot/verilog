module mux_4_2(
	input D0, 
	input D1, 
	input D2, 
	input D3,
	input S1, 
	input S0, 
	output Y
);

	wire x1,x2,x3,x4 ; 
	assign x1 = D0&(~S1)&(~S0) ; 
	assign x2 = D1&(~S1)&S0 ; 
	assign x3 = D2&S1&(~S0) ; 
	assign x4 = D3&S1&S0 ; 
	assign Y = x1|x2|x3|x4; 
endmodule