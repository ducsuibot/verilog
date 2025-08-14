// Module này minh họa cách các phép gán blocking (=) cập nhật giá trị tuần tự trong một mạch tổ hợp.
module blocking_combinational (
    input wire a,
    output reg b, c, d
);
    always @(a) begin
        b = a;
        c = b; // c sẽ lấy giá trị mới của b, tức là a
        d = c; // d sẽ lấy giá trị mới của c, tức là a
    end
endmodule