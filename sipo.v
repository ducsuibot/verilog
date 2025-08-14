module sipo(
    input wire clk,           // Clock
    input wire reset,         // Active high reset
    input wire serial_in,     // Dữ liệu nối tiếp
    output reg [3:0] parallel_out // Dữ liệu song song Q3 Q2 Q1 Q0
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            parallel_out <= 4'b0000; // Xóa dữ liệu khi reset
        end else begin
            // đưa serial_in vào vào từng bit của parallel
            parallel_out <= {parallel_out[2:0], serial_in};
        end
    end

endmodule
