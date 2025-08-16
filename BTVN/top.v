`timescale 1ns / 1ps

module top(
    input clk, rst_n,
    output [5:0] second,
    output [5:0] minute,
    output [4:0] hour,
    output [4:0] day,
    output [3:0] month,
    output [15:0] year
);
    // Wire kết nối
    wire clk_div;
    wire inc_m, inc_h, inc_d, inc_month, inc_year;

    // Tạo xung 1Hz
    clk_1s  my_1s (.clk(clk), .rst_n(rst_n), .clk_div(clk_div));

    // Đếm giây
    cnt_60s my_60s (.clk_div(clk_div), .rst_n(rst_n), .inc_m(inc_m), .second(second));

    // Đếm phút
    cnt_60m my_60m (.inc_m(inc_m), .rst_n(rst_n), .inc_h(inc_h), .minute(minute));

    // Đếm giờ
    cnt_24h my_24h (.inc_h(inc_h), .rst_n(rst_n), .inc_d(inc_d), .hour(hour));

    // Đếm ngày
    cnt_day my_day (.inc_d(inc_d), .rst_n(rst_n), .month(month), .year(year), .inc_month(inc_month), .day(day));

    // Đếm tháng
    cnt_month my_month (.inc_month(inc_month), .rst_n(rst_n), .inc_year(inc_year), .month(month));

    // Đếm năm
    cnt_year my_year (.inc_year(inc_year), .rst_n(rst_n), .year(year));

endmodule
