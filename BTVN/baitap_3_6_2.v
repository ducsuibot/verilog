module baitap_3_6_2(output reg clock); // clock_gen
	// hối initial: Khối này chỉ chạy một lần duy nhất khi bắt đầu mô phỏng
	initial 
		clock = 1'b0; // khởi tạo giá trị ban đầu cho tín hiệu clock là 0 (1'b0) 
	always 
		#10 clock = ~clock;
		//  Mỗi lần chạy, nó chờ 10 đơn vị thời gian.
		//nó gán giá trị ngược lại của clock cho chính nó
endmodule