`timescale 1ns / 1ps

module cnt_day(
    input inc_d,          // tín hiệu tăng ngày (từ cnt_24h)
    input rst_n,
    input [3:0] month,    // tháng hiện tại (1-12)
    input [15:0] year,    // năm hiện tại
    output reg inc_month, // báo sang tháng mới
    output reg [4:0] day  // ngày (1-31)
);

    function [5:0] days_in_month;
        input [3:0] m;
        input [15:0] y;
        begin
            case (m)
                1,3,5,7,8,10,12: days_in_month = 31;
                4,6,9,11:         days_in_month = 30;
                2: begin
                    if((y % 400 == 0) || ((y % 4 == 0) && (y % 100 != 0)))
                        days_in_month = 29; // năm nhuận
                    else
                        days_in_month = 28;
                end
                default: days_in_month = 31;
            endcase
        end
    endfunction

    always@(posedge inc_d or negedge rst_n) begin
        if(~rst_n) begin
            day <= 1;
            inc_month <= 0;
        end else begin
            if(day == days_in_month(month, year)) begin
                day <= 1;
                inc_month <= 1;
            end else begin
                day <= day + 1;
                inc_month <= 0;
            end
        end
    end
endmodule
