`timescale 1ns / 1ps

module cnt_24h(
input clk_5hz, inc_h, rst_n, 
input enable,     //Enable chinh tang giam 
input up ,down,
output reg inc_d, 
output reg [4:0] hour
    );
    wire clk_sel = (enable) ? clk_5hz : inc_h;
    
    always@(posedge clk_sel or negedge rst_n) begin
      if(~rst_n) begin
        inc_d  <= 0;
        hour <= 0;
      end 
      else if(enable) begin
        inc_d <= 0;
        if(up) 
          hour <= (hour == 23) ? 0 : hour + 1;
        else if (down) 
          hour <= (hour == 0) ? 23 : hour -1;
        else 
          hour <= hour;
      end 
      else begin
        if(hour == 23) begin
          hour <= 0;
          inc_d  <= 1;
        end
        else begin
          hour <= hour + 1;
          inc_d <= 0;
        end
      end
    end
endmodule
