`timescale 1ns / 1ps

module cnt_60s(
input clk_5hz, clk_1s, rst_n, 
input enable,     //Enable chinh tang giam 
input up ,down,
output reg inc_m, 
output reg [5:0] second
    );
    wire clk_sel = (enable) ? clk_5hz : clk_1s;
    
    always@(posedge clk_sel or negedge rst_n) begin
      if(~rst_n) begin
        inc_m  <= 0;
        second <= 0;
      end 
      else if(enable) begin
        inc_m <= 0;
        if(up) 
          second <= (second == 59) ? 0 : second + 1;
        else if (down) 
          second <= (second == 0) ? 59 : second -1;
        else 
          second <= second;
      end 
      else begin
        if(second == 59) begin
          second <= 0;
          inc_m  <= 1;
        end
        else begin
          second <= second + 1;
          inc_m <= 0;
        end
      end
    end
endmodule
