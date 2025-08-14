// 16-bit Linear Feedback Shift Register (LFSR)
// A common and simple PRNG implementation in hardware.
// The taps are chosen for a maximal length sequence (65535 states before repeating).

module lfsr_16bit_prng (
    input clk,          // Clock signal
    input reset_n,      // Asynchronous active-low reset
    input enable,       // Enable signal to advance the LFSR
    input [15:0] seed,  // 16-bit seed for initialization
    output [15:0] rand_out // 16-bit pseudo-random output
);

    // Internal register to hold the LFSR's state
    reg [15:0] lfsr_reg;

    // Assign the output to the current state of the register
    assign rand_out = lfsr_reg;

    // Logic for updating the LFSR state
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // Asynchronous reset: initialize with the seed
            lfsr_reg <= seed;
        end else if (enable) begin
            // Perform the feedback calculation and shift
            // This is a 16-bit LFSR with taps at bit positions 15, 14, 12, and 3.
            // These taps are a known "primitive polynomial" for a maximal length sequence.
            lfsr_reg <= {lfsr_reg[14:0], (lfsr_reg[15] ^ lfsr_reg[14] ^ lfsr_reg[12] ^ lfsr_reg[3])};
        end
    end

endmodule