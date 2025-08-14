module blocking_sequential (
    input wire clk,
    input wire a,
    output reg b, c, d
);
    always @(posedge clk) begin
        b = a;
        c = b; // c lấy giá trị mới của b
        d = c; // d lấy giá trị mới của c
    end
endmodule