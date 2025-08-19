module full_subtractor(A,B,C,D,Br); 
	input A,B,C;
	output D,Br;
	
	assign D = A ^ B ^ C; 
	assign Br = (B&C)|(~A&C)|(~A&B);
endmodule