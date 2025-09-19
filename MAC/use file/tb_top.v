`timescale 1ns/1ps
module tb_top;
    reg [10:0] in;
    wire [5:0] out;

    // DUT
    top dut(.a(in[3:0]), .b(in[7:4]), .sel(in[10:8]), .out(out));

    // golden output memory
    reg [5:0] golden_mem [0:2047];  
    integer i, errors;

    initial begin
        // load golden output file do C sinh ra
        $readmemb("E:/TEST/golden_output.txt", golden_mem);

        in = 0;
        errors = 0;

        for(i = 0; i < 2048; i = i + 1) begin
            #10 in = i;
            #1  if(out !== golden_mem[i]) begin
                    $display("Mismatch at i=%0d: a=%0d b=%0d sel=%0d | out=%0d golden=%0d",
                              i, in[3:0], in[7:4], in[10:8], out, golden_mem[i]);
                    errors = errors + 1;
                end
        end

        if(errors == 0)
            $display("All tests passed!");
        else
            $display("Total mismatches = %0d", errors);

        $stop;
    end
endmodule
