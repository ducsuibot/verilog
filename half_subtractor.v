module half_subtractor(A,B,D,Br);
	input A; 
	input B; 
	output D;
	output Br;
	
	xor Subtract(D,A,B);
	and Borrow(Br,~A,B); 
endmodule
	