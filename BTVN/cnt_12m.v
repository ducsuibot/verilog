`timescale 1ns / 1ps

module cnt_12m(
input clk_5hz, inc_mon, rst_n, 
input enable,     //Enable chinh tang giam 
input up ,down,
output reg inc_y, 
output reg [3:0] month
    );
    wire clk_sel = (enable) ? clk_5hz : inc_mon;
    
    always@(posedge clk_sel or negedge rst_n) begin
      if(~rst_n) begin
        inc_y  <= 0;
        month <= 1;
      end 
      else if(enable) begin
        inc_y <= 0;
        if(up) 
          month <= (month == 12) ? 1 : month + 1;
        else if (down) 
          month <= (month == 1) ? 12 : month -1;
        else 
          month <= month;
      end 
      else begin
        if(month == 12) begin
          month <= 1;
          inc_y  <= 1;
        end
        else begin
          month <= month + 1;
          inc_y <= 0;
        end
      end
    end
endmodule
