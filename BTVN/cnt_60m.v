`timescale 1ns / 1ps

module cnt_60m(
input inc_m, rst_n,
output reg inc_h,
output reg [5:0] minute
    );
    always@(posedge inc_m or negedge rst_n) begin
      if(~rst_n) begin
        minute <= 0;
        inc_h  <= 0;
      end else begin
        if(minute == 59) begin
          minute <= 0;
          inc_h  <= 1;
        end
        else begin
          minute <= minute + 1;
          inc_h  <= 0;
        end
      end
    end
endmodule