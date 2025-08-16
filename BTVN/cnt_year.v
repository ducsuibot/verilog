`timescale 1ns / 1ps

module cnt_year(
    input inc_year,       // từ cnt_month
    input rst_n,
    output reg [15:0] year
);
    always@(posedge inc_year or negedge rst_n) begin
        if(~rst_n)
            year <= 2025;  // năm khởi tạo
        else
            year <= year + 1;
    end
endmodule
