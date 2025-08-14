module tri_state_buffer(
	input a, 
	input s, 
	output d
); 
assign d = s? a:1'bz; // trở kháng cao 
endmodule