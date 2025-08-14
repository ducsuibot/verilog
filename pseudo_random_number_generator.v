// lcg_prng_no_ops.v
module pseudo_random_number_generator #(
    parameter WIDTH = 32,
    parameter [WIDTH-1:0] A = 32'd1103515245,
    parameter [WIDTH-1:0] C = 32'd12345,
    parameter [WIDTH-1:0] SEED = 32'h1
)(
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   enable,
    input  wire                   load_seed,
    input  wire [WIDTH-1:0]       seed_in,
    output reg  [WIDTH-1:0]       rnd,
    output wire                   rnd_bit
);
    wire [2*WIDTH-1:0] mult_out;
    wire [WIDTH-1:0]   add_out;

    // Bộ nhân n-bit
    mult_nbit #(.WIDTH(WIDTH)) u_mult (
        .a(rnd),
        .b(A),
        .product(mult_out)
    );

    // Bộ cộng n-bit
    adder_nbit #(.WIDTH(WIDTH)) u_add (
        .a(mult_out[WIDTH-1:0]), // modulo 2^WIDTH
        .b(C),
        .sum(add_out)
    );

    assign rnd_bit = rnd[0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            rnd <= SEED;
        else if (load_seed)
            rnd <= seed_in;
        else if (enable)
            rnd <= add_out;
    end
endmodule
