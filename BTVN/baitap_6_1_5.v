// 6.1.5 tham số hoá
module adder(a,b,cin,sum,cout); // adder
	parameter WIDTH = 8 ;
	input [WIDTH-1:0]a,b;
	input cin;
	output [WIDTH-1:0] sum;
	output cout;
	assign {cout,sum}= a+b+cin;
endmodule

// adder #(16) name(.a(src1))// nối chân