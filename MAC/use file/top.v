module top(a, b,sel, out);
    input [3:0] a, b;
    input [2:0] sel;
    output [5:0] out;
    reg [5:0] out;

    function [5:0] hiura;
        input [3:0] a, b;
        input [2:0] sel;
        begin
            case(sel)
            3'b000 : hiura = a;
            3'b001 : hiura = a + b;
            3'b010 : hiura = a - b;
            3'b011 : begin
                if(b != 0) hiura = a / b;
                else hiura = 0;
            end
            3'b100 : hiura = a % 1;
            3'b101 : hiura = a << 1;
            3'b110 : hiura = a >> 1;
            3'b111 : hiura = (a > b);
            endcase
        end
    endfunction

    always @(a, b, sel) begin
        out = hiura(a, b, sel);
    end
endmodule