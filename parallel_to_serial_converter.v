module parallel_to_serial_converter (
    input wire clk,
    input wire reset,
    input wire load_en, // Tín hiệu điều khiển nạp dữ liệu song song
    input wire [3:0] parallel_in,
    output wire serial_out
);

    // Thanh ghi nội bộ để lưu trữ dữ liệu
    reg [3:0] shift_reg;
    reg [2:0] counter; // Bộ đếm để biết khi nào đã dịch đủ 4 bit

    // Tín hiệu đầu ra nối tiếp
    assign serial_out = shift_reg[0];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 4'b0000;
            counter <= 3'b000;
        end
        else begin
            if (load_en) begin
                // Nạp dữ liệu song song khi load_en = 1
                shift_reg <= parallel_in;
                counter <= 3'b000; // Reset bộ đếm khi nạp dữ liệu
            end
            else begin
                // Dịch chuyển dữ liệu sang phải khi load_en = 0
                shift_reg <= {1'b0, shift_reg[3:1]};
                counter <= counter + 1;
            end
        end
    end

endmodule