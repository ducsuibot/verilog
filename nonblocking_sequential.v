module nonblocking_sequential (
    input wire clk,
    input wire a,
    output reg b, c, d
);
    always @(posedge clk) begin
        b <= a;
        c <= b; // c lấy giá trị của b tại thời điểm trước xung clk
        d <= c; // d lấy giá trị của c tại thời điểm trước xung clk
    end
endmodule

