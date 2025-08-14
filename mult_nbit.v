// mult_nbit.v
module mult_nbit #(
    parameter WIDTH = 32
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output reg  [2*WIDTH-1:0] product
);
    integer i;
    always @* begin
        product = {2*WIDTH{1'b0}};
        for (i = 0; i < WIDTH; i = i + 1) begin
            if (b[i])
                product = product + (a << i);
        end
    end
endmodule
