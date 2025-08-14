// dịch trái : số học : <<< , logic : << 
// dịch phải : sô học : >>> , logic : >>
module baitap_3_5_8();
	initial begin
		// dịch trái
		$display ("4'b1001 << 1 = %b", (4'b1001 << 1));
		$display ("4'b10x1 << 1 = %b", (4'b10x1 << 1));
		// dịch phải
		$display("4'b1001 >> 1 = %b", (4'b1001 >> 1));
		#10 $finish;
	end
endmodule