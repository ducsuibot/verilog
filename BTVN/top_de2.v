`timescale 1ns/1ps
module top_de2(
    input  wire        CLOCK_50,
    input  wire [3:0]  KEY,          // KEY[0]..KEY[3] active-low
    input  wire        RESET_N,      // công tắc/reset ngoài, active-low
    output wire [6:0]  HEX0,
    output wire [6:0]  HEX1,
    output wire [6:0]  HEX2,
    output wire [6:0]  HEX3,
    output wire [6:0]  HEX4,
    output wire [6:0]  HEX5,
    output wire [6:0]  HEX6,
    output wire [6:0]  HEX7
);
    // Gán nút:
    // KEY0: reset (kết hợp với RESET_N)
    // KEY1: mode_toggle
    // KEY2: edit_toggle
    // KEY3: select_item
    wire rst_n = RESET_N & KEY[0];

    // Debounce cho KEY1..KEY3 và 2 nút UP/DOWN giả định dùng SW? 
    // Ở đây minh hoạ: dùng thêm 2 input ảo từ KEY[1]/[2] cho up/down bằng cách giữ phím -> xung 1 lần.
    // Thực tế bạn có thể map UP/DOWN sang 2 KEY khác hoặc SW. Ở đây: KEY1=mode, KEY2=edit, KEY3=select.
    // Ta thêm 2 công tắc ảo: không có, vậy demo dùng SW chưa có → giải pháp: tái dụng KEY1/KEY2 làm up/down khi edit_mode=1?
    // Để rõ ràng, ta giả sử có thêm 2 nút rời: UP_N và DOWN_N. Nếu không có, bạn map lại.
    // ----- Nếu board bạn CHỈ có 4 KEY, hãy đổi:
    //  - KEY1: mode_toggle
    //  - KEY2: edit_toggle
    //  - KEY3: select_item
    //  - Dùng SW[1]↑ thành up, SW[0]↑ thành down (không có trong cổng top này).
    // => Để giữ code chạy ngay, ta tạo 2 input nội bộ tie-off = 1 (ko chỉnh). Khi bạn có SW, nối vào đây.

    // Debounce cho KEY1..KEY3
    wire db_mode, db_edit, db_select;
    debounce u_db_mode  (.clk(CLOCK_50), .rst_n(rst_n), .btn_n(KEY[1]), .stable(db_mode));
    debounce u_db_edit  (.clk(CLOCK_50), .rst_n(rst_n), .btn_n(KEY[2]), .stable(db_edit));
    debounce u_db_sel   (.clk(CLOCK_50), .rst_n(rst_n), .btn_n(KEY[3]), .stable(db_select));

    wire p_mode, p_edit, p_select;
    onepulse u_op_mode  (.clk(CLOCK_50), .rst_n(rst_n), .level(db_mode),   .pulse(p_mode));
    onepulse u_op_edit  (.clk(CLOCK_50), .rst_n(rst_n), .level(db_edit),   .pulse(p_edit));
    onepulse u_op_sel   (.clk(CLOCK_50), .rst_n(rst_n), .level(db_select), .pulse(p_select));

    // ---- Up/Down: (tạm thời không có nút thật) -> tie-off 0
    wire up_pulse   = 1'b0;
    wire down_pulse = 1'b0;

    // Chia clock
    wire clk_1hz, blink_1hz;
    clk_divider #(.CLOCK_FREQ(50_000_000)) u_div (
        .clk(CLOCK_50), .rst_n(rst_n),
        .clk_1hz(clk_1hz), .blink_1hz(blink_1hz)
    );

    // Controller
    wire mode_display, edit_mode;
    wire [2:0] select_item;
    wire inc_pulse, dec_pulse;

    controller u_ctl (
        .clk(CLOCK_50), .rst_n(rst_n),
        .mode_toggle_pulse(p_mode),
        .edit_toggle_pulse(p_edit),
        .select_item_pulse(p_select),
        .up_pulse(up_pulse),
        .down_pulse(down_pulse),
        .mode_display(mode_display),
        .edit_mode(edit_mode),
        .select_item(select_item),
        .inc_pulse(inc_pulse),
        .dec_pulse(dec_pulse)
    );

    // Counter
    wire [5:0] sec, min, day;
    wire [4:0] hour;
    wire [3:0] month;
    wire [11:0] year;

    time_date_counter u_cnt (
        .clk_1hz(clk_1hz),
        .rst_n(rst_n),
        .edit_mode(edit_mode),
        .select_item(select_item),
        .inc_pulse(inc_pulse),
        .dec_pulse(dec_pulse),
        .sec(sec), .min(min), .hour(hour),
        .day(day), .month(month), .year(year)
    );

    // Display mux
    wire [3:0] d7,d6,d5,d4,d3,d2,d1,d0;
    wire e7,e6,e5,e4,e3,e2,e1,e0;

    display_mux u_mux (
        .mode_display(mode_display),
        .edit_mode(edit_mode),
        .select_item(select_item),
        .blink_1hz(blink_1hz),
        .sec(sec), .min(min), .hour(hour),
        .day(day), .month(month), .year(year),
        .dig7(d7), .dig6(d6), .dig5(d5), .dig4(d4),
        .dig3(d3), .dig2(d2), .dig1(d1), .dig0(d0),
        .en7(e7), .en6(e6), .en5(e5), .en4(e4),
        .en3(e3), .en2(e2), .en1(e1), .en0(e0)
    );

    // 8 bộ giải mã BCD→7 đoạn (active-low)
    bcd7seg U7 (.bcd(d7), .enable(e7), .seg_n(HEX7));
    bcd7seg U6 (.bcd(d6), .enable(e6), .seg_n(HEX6));
    bcd7seg U5 (.bcd(d5), .enable(e5), .seg_n(HEX5));
    bcd7seg U4 (.bcd(d4), .enable(e4), .seg_n(HEX4));
    bcd7seg U3 (.bcd(d3), .enable(e3), .seg_n(HEX3));
    bcd7seg U2 (.bcd(d2), .enable(e2), .seg_n(HEX2));
    bcd7seg U1 (.bcd(d1), .enable(e1), .seg_n(HEX1));
    bcd7seg U0 (.bcd(d0), .enable(e0), .seg_n(HEX0));
endmodule
