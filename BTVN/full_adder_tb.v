`timescale 1 ns / 100 fs

module baitap_3_6_1;
    reg [3:0] stim;
    wire s, c;

    initial begin
        $monitor("s=%b c=%b stim=%b", s, c, stim);
    end

    initial #50 $stop;

    initial begin // Stimulus generation
        for (stim = 4'h0; stim < 4'h8; stim = stim + 1) begin
            #5;
        end
    end

endmodule