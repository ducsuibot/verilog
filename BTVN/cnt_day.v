`timescale 1ns / 1ps

module cnt_day(
input clk_5hz, inc_d, rst_n,
input [4:0] set_day,    //Set ngay theo tung thang , nam nhuan   
input enable,           //Enable chinh tang giam 
input up ,down,
output reg inc_mon, 
output reg [4:0] day
    );
    wire clk_sel = (enable) ? clk_5hz : inc_d;
    always@(posedge clk_sel or negedge rst_n) begin
      if(~rst_n) begin
        inc_mon <= 0;
        day     <= 1;
      end
      else if(enable) begin
        inc_mon <= 0;
        if(up)
          day <= (day == set_day) ? 1 : day + 1;
        else if(down) 
          day <= (day == 1) ? set_day : day - 1;
        else 
          day <= day;
      end
      else begin 
        if(day == set_day) begin
          day <= 1;
          inc_mon <= 1;
        end
        else begin
          day <= day + 1;
          inc_mon <= 0;
        end
      end
    end
endmodule
