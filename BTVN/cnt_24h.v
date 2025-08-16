`timescale 1ns / 1ps

module cnt_24h(
input inc_h, rst_n,
output reg inc_d,
output reg [4:0] hour
    );
    always@(posedge inc_h or negedge rst_n) begin
      if(~rst_n) begin
        hour  <= 0;
        inc_d <= 0;
      end else begin
        if(hour == 23) begin
          hour  <= 0;
          inc_d <= 1;
        end else begin
          hour <= hour + 1;
          inc_d <= 0;
        end
      end
    end
endmodule