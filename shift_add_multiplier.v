module shift_add_multiplier(
    input  [15:0] a,
    input  [15:0] b,
    output [31:0] product
);
    // Xử lý dấu
    wire a_sign = a[15];
    wire b_sign = b[15];
    wire result_sign = a_sign ^ b_sign;
    
    // Lấy giá trị tuyệt đối cho phép nhân
    wire [15:0] a_abs = a_sign ? -a : a;
    wire [15:0] b_abs = b_sign ? -b : b;
    
    // Sử dụng thuật toán dịch và cộng
    reg [31:0] partial_product;
    integer i;

    // Phép nhân thực hiện trong một khối always combinational
    always @(*) begin
        partial_product = 32'b0;
        for (i = 0; i < 16; i = i + 1) begin
            if (b_abs[i] == 1'b1) begin
                partial_product = partial_product + (a_abs << i);
            end
        end
    end

    // Gán kết quả cuối cùng, xử lý lại dấu nếu cần
    assign product = result_sign ? -partial_product : partial_product;
endmodule