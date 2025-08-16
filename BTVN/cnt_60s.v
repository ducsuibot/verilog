`timescale 1ns / 1ps

module cnt_60s(
input clk_div, rst_n,
output reg inc_m,
output reg [5:0] second //60s
    );
    always@(posedge clk_div or negedge rst_n) begin
      if(~rst_n) begin
        second <= 0;
        inc_m  <= 0; 
      end else begin
        if(second == 59) begin
          inc_m <= 1;
          second <= 0;
        end else begin
          inc_m <= 0;
          second <= second + 1;
        end
      end
    end
endmodule