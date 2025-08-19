`timescale 1ns / 1ps

module day_mon(
input [4:0] month,
input [1:0] year_lsb,  
output reg [4:0] set_day
    );
    always@(*) begin
      case(month)
      5'd1 : set_day = 31;
      5'd2 : set_day = (year_lsb == 0) ? 29 : 28;
      5'd3 : set_day = 31;
      5'd4 : set_day = 30;
      5'd5 : set_day = 31;
      5'd6 : set_day = 30;
      5'd7 : set_day = 31;
      5'd8 : set_day = 31;
      5'd9 : set_day = 30;
      5'd10: set_day = 31;
      5'd11: set_day = 30;
      5'd12: set_day = 31;
      default : set_day = 31;
      endcase
    end
endmodule
