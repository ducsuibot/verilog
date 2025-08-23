`timescale 1ns / 1ps

module cnt_60p(
input clk_5hz, inc_m, rst_n, 
input enable,     //Enable chinh tang giam 
input up ,down,
output reg inc_h, 
output reg [5:0] minute
    );
    wire clk_sel = (enable) ? clk_5hz : inc_m;
    
    always@(posedge clk_sel or negedge rst_n) begin
      if(~rst_n) begin
        inc_h  <= 0;
        minute <= 0;
      end 
      else if(enable) begin
        inc_h <= 0;
        if(up) 
          minute <= (minute == 59) ? 0 : minute + 1;
        else if (down) 
          minute <= (minute == 0) ? 59 : minute -1;
        else 
          minute <= minute;
      end 
      else begin
        if(minute == 59) begin
          minute <= 0;
          inc_h  <= 1;
        end
        else begin
          minute <= minute + 1;
          inc_h <= 0;
        end
      end
    end
endmodule
