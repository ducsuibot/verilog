// =============================================================================
// Module: mac_top
// Mô tả: Module top để kiểm tra chức năng của mac_unit.
// =============================================================================
module mac_top(
    input  [15:0] in_a,
    input  [15:0] in_b,
    input  [15:0] in_c,
    output [31:0] mac_out
);
    // Khởi tạo module MAC
    mac_unit10 u_mac (
        .in_a   (in_a),
        .in_b   (in_b),
        .in_c   (in_c),
        .mac_out(mac_out)
    );
endmodule
