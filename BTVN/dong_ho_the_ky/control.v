`timescale 1ns / 1ps

module control(
input [2:0] sel,
input up_push, down_push,
input mode,   //0 = dem, 1 = chinh
output reg up, down,
output reg [5:0] enable
    );
    
    always@(mode,enable) begin
      if(mode) begin
        case(sel) 
          3'd0: enable = 6'b000001; // Chinh s
          3'd1: enable = 6'b000010; // Chinh p
          3'd2: enable = 6'b000100; // Chinh h
          3'd3: enable = 6'b001000; // Chinh d
          3'd4: enable = 6'b010000; // Chinh m
          3'd5: enable = 6'b100000; // Chinh y
          default: enable = 6'b000000;
        endcase
      end
      else 
        enable = 6'b000000;
    end
    
    always@(up_push,down_push) begin
      up   = up_push;
      down = down_push;
    end
endmodule
