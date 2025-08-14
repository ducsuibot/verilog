module shift_register_4bit (
    input wire clk,
    input wire reset_n,
    input wire [1:0] mode,
    input wire serial_in,
    input wire [3:0] parallel_in,
    output wire serial_out,
    output wire [3:0] parallel_out
);

    reg [3:0] q;

    // Output assignments
    assign parallel_out = q;
    assign serial_out = q[0];

    // Main logic for the shift register
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            q <= 4'b0000;
        end else begin
            case (mode)
                // PISO (Parallel-In, Serial-Out)
                2'b00: begin
                    q <= parallel_in;
                end
                // SIPO (Serial-In, Parallel-Out)
                2'b01: begin
                    q <= {serial_in, q[3:1]};
                end
                // SISO (Serial-In, Serial-Out)
                2'b10: begin
                    q <= {serial_in, q[3:1]};
                end
                // PIPO (Parallel-In, Parallel-Out)
                2'b11: begin
                    q <= parallel_in;
                end
                default: begin
                    q <= q;
                end
            endcase
        end
    end
endmodule