// File: bin_to_bcd_4bit.v
// Module chuyển đổi nhị phân 4-bit sang BCD bằng Double Dabble

module bin_to_bcd_4bit(
    input  [3:0] bin_in,
    output reg [3:0] bcd_tens,  
    output reg [3:0] bcd_unit   
);
    reg [7:0] temp_bcd;
    reg [3:0] bin_reg;
    integer i;

    always @(*) begin
        // Khởi tạo
        temp_bcd = 8'h00;
        bin_reg = bin_in;
        
        // Vòng lặp cho 4 bit đầu vào
        for (i = 0; i < 4; i = i + 1) begin
            // Kiểm tra và cộng 3 cho các hàng BCD
            if (temp_bcd[3:0] > 4) begin
                temp_bcd[3:0] = temp_bcd[3:0] + 3;
            end
            if (temp_bcd[7:4] > 4) begin
                temp_bcd[7:4] = temp_bcd[7:4] + 3;
            end
            
            // Dịch trái cả thanh ghi BCD và số nhị phân
            temp_bcd = {temp_bcd[6:0], bin_reg[3]};
            bin_reg = {bin_reg[2:0], 1'b0};
        end
        
        // Gán đầu ra
        bcd_tens = temp_bcd[7:4];
        bcd_unit = temp_bcd[3:0];
    end
endmodule