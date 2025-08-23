`timescale 1ns / 1ps

module top(
    input clk, rst_n,
    input sw,                    // 0: HH:MM:SS, 1: DD:MM:YY
    input [2:0] sel,             // 0s 1p 2h 3d 4m 5y
    input up_push, down_push,   // nút nhấn
    input mode,                 // 0: đếm, 1: chỉnh
    output [6:0] led1, led2, led3, led4, led5, led6
);

    wire clk_1s, clk_5hz;
    wire up, down;
    wire [5:0] enable;

    wire [5:0] second;
    wire [5:0] minute;
    wire [4:0] hour;
    wire [4:0] day;
    wire [3:0] month;
    wire [6:0] year;

    wire inc_m, inc_h, inc_d, inc_mon, inc_y;

    //clk_div
    clk_div #(.clk_sys(50_000_000)) clk_div_t (
        .clk(clk),
        .rst_n(rst_n),
        .clk_1s(clk_1s),
        .clk_5hz(clk_5hz)
    );

    //control
    control control_t (
        .sel(sel),
        .up_push(up_push),
        .down_push(down_push),
        .mode(mode),
        .up(up),
        .down(down),
        .enable(enable)
    );

    // cnt_60s
    cnt_60s cnt_60s_t (
        .clk_5hz(clk_5hz),
        .clk_1s(clk_1s),
        .rst_n(rst_n),
        .enable(enable[0]),
        .up(up),
        .down(down),
        .inc_m(inc_m),
        .second(second)
    );

    // cnt_60p
    cnt_60p cnt_60p_t (
        .clk_5hz(clk_5hz),
        .inc_m(inc_m),
        .rst_n(rst_n),
        .enable(enable[1]),
        .up(up),
        .down(down),
        .inc_h(inc_h),
        .minute(minute)
    );

    // cnt_24h
    cnt_24h cnt_24h_t (
        .clk_5hz(clk_5hz),
        .inc_h(inc_h),
        .rst_n(rst_n),
        .enable(enable[2]),
        .up(up),
        .down(down),
        .inc_d(inc_d),
        .hour(hour)
    );

    // day_top 
    day_top day_top_t (
        .clk_5hz(clk_5hz),
        .inc_d(inc_d),
        .rst_n(rst_n),
        .enable(enable[3]),
        .up(up),
        .down(down),
        .inc_mon(inc_mon),
        .day(day)
    );

    // cnt_12m 
    cnt_12m cnt_12m_t (
        .clk_5hz(clk_5hz),
        .inc_mon(inc_mon),
        .rst_n(rst_n),
        .enable(enable[4]),
        .up(up),
        .down(down),
        .inc_y(inc_y),
        .month(month)
    );

    // cnt_year
    cnt_year cnt_year_t (
        .clk_5hz(clk_5hz),
        .inc_y(inc_y),
        .rst_n(rst_n),
        .enable(enable[5]),
        .up(up),
        .down(down),
        .year(year)
    );

    // display 
    display display_t (
        .switch(sw),
        .second(second),
        .minute(minute),
        .hour(hour),
        .day(day),
        .month(month),
        .year(year),
        .led1(led1),
        .led2(led2),
        .led3(led3),
        .led4(led4),
        .led5(led5),
        .led6(led6)
    );

endmodule
