`timescale 1ns / 1ps

module Data_Memory(
input         clk, WE,
input  [31:0] A,WD,
output [31:0] RD
    );
    reg [31:0] data_mem [63:0];
    
    assign RD = data_mem[A[31:2]];
    always@(posedge clk) begin
        if (WE) begin
            data_mem[A[31:2]] <= WD;         
        end
    end
endmodule
