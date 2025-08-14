// Operator {v1,v2} các vector phía trái (Most Significant Bits - MSB) của danh sách vt con có ý nghĩa cao hơn phải 
module baitap_3_5_4(out,a,b,c,d); // module concatenate
	input [2:0] a;
	input [1:0] b,c;
	input d;
	output [9:0] out;
	assign out = {a[1:0],b,c,d,a[2]}; 
endmodule 