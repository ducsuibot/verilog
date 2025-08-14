module serial_in_serial_out (
    input wire shift_in,
    input wire clock,
    output reg shift_out
);

    // Khai báo thanh ghi nội bộ 3 bit (fl_flop_1, fl_flop_2, fl_flop_3)
    // Tổng cộng sẽ có 4 D-flip-flop:
    // DFF1 -> internal_reg[2]
    // DFF2 -> internal_reg[1]
    // DFF3 -> internal_reg[0]
    // DFF4 -> shift_out
    reg [2:0] internal_reg;

    always @(posedge clock)
    begin
        // Dịch chuyển các bit.
        // Đây là cách đúng để mô phỏng một thanh ghi dịch
        // internal_reg[2] là bit đầu tiên
        // internal_reg[0] là bit cuối cùng
        
        // Dịch chuyển dữ liệu từ các thanh ghi cũ sang thanh ghi mới
        internal_reg[0] <= internal_reg[1];
        internal_reg[1] <= internal_reg[2];
        internal_reg[2] <= shift_in;
        
        // Gán bit cuối cùng ra đầu ra
        shift_out <= internal_reg[0];

    end

endmodule