module encoder_4_2(
	input Y0, 
	input Y1, 
	input Y2, 
	input Y3,
	output A1, 
	output A0
);
	assign A1 = ((~Y3)&Y2&(~Y1)&(~Y0))|((Y3)&(~Y2)&(~Y1)&(~Y0)) ; 
	assign A0 = ((~Y3)&(~Y2)&(Y1)&(~Y0))|((Y3)&(~Y2)&(~Y1)&(~Y0)) ;
endmodule	