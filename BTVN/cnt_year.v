`timescale 1ns / 1ps

module cnt_year(
input clk_5hz, inc_y, rst_n, 
input enable,     //Enable chinh tang giam 
input up ,down, 
output reg [6:0] year
    );
    wire clk_sel = (enable) ? clk_5hz : inc_y;
    
    always@(posedge clk_sel or negedge rst_n) begin
      if(~rst_n) begin
        year <= 7'd25;
      end 
      else if(enable) begin
        if(up) 
          year <= (year == 7'd99) ? 7'd25 : year + 1;
        else if (down) 
          year <= (year == 12'd25) ? 7'd99 : year -1;
        else 
          year <= year;
      end 
      else begin
        if(year == 7'd99) begin
          year <= 7'd25;
        end
        else begin
          year <= year + 1;
        end
      end
    end
endmodule
