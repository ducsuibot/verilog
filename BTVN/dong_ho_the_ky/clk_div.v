`timescale 1ns / 1ps

module clk_div #(parameter clk_sys = 20)(
input clk, rst_n,
output reg clk_1s, clk_5hz
    );
reg [$clog2(clk_sys/2)-1:0] cnt_1s;
reg [$clog2(clk_sys/(2*5))-1:0] cnt_5hz;
// CLK_1S
always@(posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    cnt_1s <= 0;
    clk_1s <= 0;
  end
  else begin
    if(cnt_1s == clk_sys/2-1) begin
      clk_1s <= ~clk_1s;
      cnt_1s <= 0;  
    end
    else begin
      cnt_1s <= cnt_1s + 1;
    end
  end
end
//CLK_5HZ
always@(posedge clk or negedge rst_n) begin
  if(~rst_n) begin
    cnt_5hz <= 0;
    clk_5hz <= 0;
  end
  else begin
    if(cnt_5hz == (clk_sys/(2*5))-1) begin
      clk_5hz <= ~clk_5hz;
      cnt_5hz <= 0;  
    end
    else begin
      cnt_5hz <= cnt_5hz + 1;
    end
  end
end
    
endmodule
