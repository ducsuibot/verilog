module decoder_2_to_4_with_enable (
    input  wire [1:0] A,        // 2-bit input for decoding
    input  wire       enable,   // Active-high enable signal
    output reg  [3:0] D         // 4-bit output
);

    always @(A) begin
        if (enable) begin
            case (A)
                2'b00: D = 4'b0001;
                2'b01: D = 4'b0010;
                2'b10: D = 4'b0100;
                2'b11: D = 4'b1000;
                default: D = 4'b0000; // This is good practice
            endcase
        end else begin
            D = 4'b0000; // All outputs are zero when disabled
        end
    end

endmodule