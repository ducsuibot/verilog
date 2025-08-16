

module led_7_thanh(
    input  [3:0] hex_digit,         // switches chọn hex digit (binary)
    output [6:0] HEX0,
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5,
    output [6:0] HEX6,
    output [6:0] HEX7
);

    // seg phải là reg vì ta gán trong always block
    reg [6:0] segdata;

    // bộ giải mã 7-seg (active low: 0 = ON)
    always @(hex_digit) 
	 
		begin
        case (hex_digit)
            4'b0000: segdata = 7'b1000000; // 0
            4'b0001: segdata = 7'b1111001; // 1
            4'b0010: segdata = 7'b0100100; // 2
            4'b0011: segdata = 7'b0110000; // 3
            4'b0100: segdata = 7'b0011001; // 4
            4'b0101: segdata = 7'b0010010; // 5
            4'b0110: segdata = 7'b0000010; // 6
            4'b0111: segdata = 7'b1111000; // 7
            4'b1000: segdata = 7'b0000000; // 8
            4'b1001: segdata = 7'b0010000; // 9
            default: segdata = 7'b1111111; // tất cả tắt
        endcase
    end

    // xuất cùng 1 giá trị ra tất cả 8 7-seg
    assign HEX0 = segdata;
    assign HEX1 = segdata;
    assign HEX2 = segdata;
    assign HEX3 = segdata;
    assign HEX4 = segdata;
    assign HEX5 = segdata;
    assign HEX6 = segdata;
    assign HEX7 = segdata;

endmodule
