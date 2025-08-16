`timescale 1ns / 1ps

module cnt_month(
    input inc_month,     // từ cnt_day
    input rst_n,
    output reg inc_year, // sang năm mới
    output reg [3:0] month
);
    always@(posedge inc_month or negedge rst_n) begin
        if(~rst_n) begin
            month <= 1;
            inc_year <= 0;
        end else begin
            if(month == 12) begin
                month <= 1;
                inc_year <= 1;
            end else begin
                month <= month + 1;
                inc_year <= 0;
            end
        end
    end
endmodule
