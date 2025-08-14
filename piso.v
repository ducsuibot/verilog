module piso (
    input wire clk,                     // Clock
    input wire shift_load_n,            // Shift/Load complement (active low load)
    input wire [3:0] parallel_in,       // B0, B1, B2, B3
    output reg serial_out               // Q3
);
    reg [3:0] shift_reg; // FF0..FF3

    always @(posedge clk) begin
        if (!shift_load_n) begin
            // Chế độ Load (active low)
            shift_reg <= parallel_in;
        end else begin
            // Chế độ Shift
            serial_out <= shift_reg[3];
            shift_reg <= {shift_reg[2:0], 1'b0}; // Nối bit
        end
    end
endmodule
