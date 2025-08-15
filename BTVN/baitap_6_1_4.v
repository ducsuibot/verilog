// 6.1.4 bộ dịch
module baitap_6_1_4(data_in,data_out,select,clk,reset);
	input [3:0] data_in;
	output reg [3:0] data_out;
	input [1:0] select; 
	input reset,clk;
	
	always @(posedge clk) begin
		if(reset) begin
			data_out <= 4'b0;
		end else case(select[1:0]) 
			2'b00: data_out <= data_out;
			2'b01: data_out <= {data_out[3],data_out[3:1]}; 
			2'b10: data_out <= {data_out[2:0],1'b0};
			2'b11: data_out <= data_in;
		endcase
	end
endmodule