`timescale 1ns / 1ps

module clk_1s #(parameter clk_sys = 2)(
input clk,
input rst_n,
output reg clk_div
    );
    reg [$clog2(clk_sys/2)-1:0] count;
    always@(posedge clk or negedge rst_n) begin
      if(~rst_n) begin
        count <= 0;
        clk_div <= 0;
      end else begin
        if(count == (clk_sys/2)-1) begin
          clk_div <= ~clk_div;
          count <= 0;
        end else begin
          count <= count + 1;
        end
      end
    end
endmodule