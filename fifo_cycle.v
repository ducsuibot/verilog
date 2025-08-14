module fifo_cycle #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 64,
    parameter ADDR_WIDTH = 6 // vì 2^6 = 64
)(
    input wire clock,
    input wire reset, // Active high, async reset

    input wire [DATA_WIDTH-1:0] buffer_in,
    input wire write_enable,
    input wire read_enable,

    output reg [DATA_WIDTH-1:0] buffer_out,
    output reg buffer_full,
    output reg buffer_empty
);

    // Bộ nhớ FIFO
    reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];

    // Con trỏ đọc/ghi
    reg [ADDR_WIDTH-1:0] write_pointer;
    reg [ADDR_WIDTH-1:0] read_pointer;

    // Bộ đếm số phần tử hiện tại
    reg [ADDR_WIDTH:0] fifo_counter; // 7 bit (0-64)

    // -----------------------
    // Cập nhật cờ full / empty
    // -----------------------
    always @(*) begin
        buffer_empty = (fifo_counter == 0);
        buffer_full  = (fifo_counter == DEPTH);
    end

    // -----------------------
    // Bộ đếm số phần tử
    // -----------------------
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            fifo_counter <= 0;
        end else begin
            case ({write_enable && !buffer_full, read_enable && !buffer_empty})
                2'b10: fifo_counter <= fifo_counter + 1; // ghi mà không đọc
                2'b01: fifo_counter <= fifo_counter - 1; // đọc mà không ghi
                default: fifo_counter <= fifo_counter;   // giữ nguyên
            endcase
        end
    end

    // -----------------------
    // Đọc dữ liệu
    // -----------------------
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            buffer_out <= 0;
        end else if (read_enable && !buffer_empty) begin
            buffer_out <= memory[read_pointer];
        end
    end

    // -----------------------
    // Ghi dữ liệu
    // -----------------------
    always @(posedge clock) begin
        if (write_enable && !buffer_full) begin
            memory[write_pointer] <= buffer_in;
        end
    end

    // -----------------------
    // Cập nhật con trỏ đọc/ghi
    // -----------------------
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            write_pointer <= 0;
            read_pointer <= 0;
        end else begin
            if (write_enable && !buffer_full) begin
                write_pointer <= (write_pointer + 1) % DEPTH;
            end
            if (read_enable && !buffer_empty) begin
                read_pointer <= (read_pointer + 1) % DEPTH;
            end
        end
    end

endmodule
