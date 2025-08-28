`timescale 1ns/1ps

module Register_File(
	input clk,
	input WE3,
	input [31:0] WD3,
	input [4:0] A1,A2,A3,
	output [31:0] RD1,RD2
);

	reg [31:0] Register[31:0]; // 32 thanh ghi mỗi thanh 32 bit
	
	integer i;
	initial begin
		for( i = 0; i < 32; i = i + 1) begin
			Register[i] = 0; 
		end
	end
	
	always @(posedge clk) begin
		if(WE3 && (A3 != 0)) begin // nếu WE3= True và A3 khác x0 = True thì ghi  
			Register[A3] <= WD3;
		end
	end
	
	assign RD1 = (A1 != 0) ? Register[A1] : 0;
	assign RD2 = (A2 != 0) ? Register[A2] : 0;
endmodule
