// 3.5.6: mở rộng dấu
module baitap_3_5_6(offset,src);
	input [7:0] offset;
	output wire [15:0] src;
	
	assign src = { {8{offset[7]}}, offset};
	// {8{offset[7]}} là kỹ thuật lặp lại bit dấu 8 lần.
	// offset[7] là bit dấu của số 8 bit.
	// { {8{offset[7]}}, offset } sẽ tạo ra một số 16-bit, trong đó:
	// 8 bit cao là bản sao của bit dấu.
	// 8 bit thấp là offset gốc
endmodule