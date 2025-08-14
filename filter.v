// =============================================================================
// Module: filter_fir_mac
// Mô tả: Bộ lọc FIR 32-tap sử dụng kiến trúc Multiply-Accumulate (MAC) tuần tự.
// Đầu vào: clock, reset, data_in (8 bit)
// Đầu ra:  data_out (24 bit), data_out_valid
// =============================================================================
module filter_fir_mac (
    input  wire           clock,
    input  wire           reset,
    input  wire [7:0]     data_in,
    output reg  [23:0]    data_out,
    output reg            data_out_valid
);

    parameter TAPS = 32;
    parameter DATA_WIDTH = 8;
    parameter COEFF_WIDTH = 8;
    parameter ACCUM_WIDTH = DATA_WIDTH + COEFF_WIDTH + $clog2(TAPS); // 8+8+5 = 21, làm tròn 24bit

    // Các hệ số bộ lọc
    reg [COEFF_WIDTH-1:0] h [TAPS-1:0];
    initial begin
        h[0] = 8'h01; h[1] = 8'h02; h[2] = 8'h03; h[3] = 8'h04;
        h[4] = 8'h05; h[5] = 8'h06; h[6] = 8'h07; h[7] = 8'h08;
        h[8] = 8'h08; h[9] = 8'h07; h[10]= 8'h06; h[11]= 8'h05;
        h[12]= 8'h04; h[13]= 8'h03; h[14]= 8'h02; h[15]= 8'h01;
        h[16] = 8'h01; h[17] = 8'h02; h[18] = 8'h03; h[19] = 8'h04;
        h[20] = 8'h05; h[21] = 8'h06; h[22] = 8'h07; h[23] = 8'h08;
        h[24] = 8'h08; h[25] = 8'h07; h[26] = 8'h06; h[27] = 8'h05;
        h[28] = 8'h04; h[29] = 8'h03; h[30] = 8'h02; h[31] = 8'h01;
    end

    // Thanh ghi dịch (shift register) để lưu trữ các mẫu dữ liệu đầu vào
    reg [DATA_WIDTH-1:0] delay_line [TAPS-1:0];

    // Thanh ghi để lưu trữ tổng dồn
    reg [ACCUM_WIDTH-1:0] accumulator;
    
    // Bộ đếm để lặp qua các tap
    reg [$clog2(TAPS)-1:0] tap_counter;
    
    // Tín hiệu điều khiển
    reg processing_done;

    // --- Khối xử lý chính ---
    always @(posedge clock) begin
        if (reset) begin
            data_out_valid <= 1'b0;
            tap_counter    <= 0;
            accumulator    <= 0;
            processing_done <= 1'b0;
            
            for (integer j = 0; j < TAPS; j = j + 1) begin
                delay_line[j] <= 0;
            end

        end else begin
            if (processing_done) begin
                data_out_valid <= 1'b0;
                tap_counter    <= 0;
                accumulator    <= 0;
                processing_done <= 1'b0;

                for (integer j = TAPS-1; j > 0; j = j - 1) begin
                    delay_line[j] <= delay_line[j-1];
                end
                delay_line[0] <= data_in;
            end

            if (tap_counter < TAPS) begin
                wire [15:0] current_data = {{8{1'b0}}, delay_line[tap_counter]};
                wire [15:0] current_coeff= {{8{1'b0}}, h[tap_counter]};
                wire [31:0] partial_product;
                
                shift_add_multiplier10 u_mul (
                    .a      (current_data),
                    .b      (current_coeff),
                    .product(partial_product)
                );
                
                accumulator <= accumulator + partial_product[ACCUM_WIDTH-1:0];

                tap_counter <= tap_counter + 1;
            
            end else begin
                data_out <= accumulator;
                data_out_valid <= 1'b1;
                processing_done <= 1'b1;
            end
        end
    end
endmodule
