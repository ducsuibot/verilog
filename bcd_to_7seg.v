// File: bcd_to_7seg.v
// Module giải mã 4-bit BCD sang 7-segment

module bcd_to_7seg(
    input  [3:0] bcd_input,
    output reg [6:0] seg_output
);
    always @(*) begin
        case (bcd_input)
            4'd0: seg_output = 7'b1000000; // 0
            4'd1: seg_output = 7'b1111001; // 1
            4'd2: seg_output = 7'b0100100; // 2
            4'd3: seg_output = 7'b0110000; // 3
            4'd4: seg_output = 7'b0011001; // 4
            4'd5: seg_output = 7'b0010010; // 5
            4'd6: seg_output = 7'b0000010; // 6
            4'd7: seg_output = 7'b1111000; // 7
            4'd8: seg_output = 7'b0000000; // 8
            4'd9: seg_output = 7'b0010000; // 9
            default: seg_output = 7'b1111111; // Tắt (hoặc lỗi)
        endcase
    end
endmodule