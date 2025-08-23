`timescale 1ns / 1ps

module display(
input switch, //HH:MM:SS = 0 DD:MM:YY : 1
input [5:0] second,
input [5:0] minute,
input [4:0] hour,
input [4:0] day,
input [3:0] month,
input [7:0] year,
output [6:0] led1, led2, led3, led4, led5, led6  
    );
    
    wire [3:0] bcd_sel1, bcd_sel2, bcd_sel3, bcd_sel4, bcd_sel5, bcd_sel6;
    
    wire [3:0] bcd_1s, bcd_0s;
    bin7_bcd2 mybin1({1'b0,second},bcd_1s,bcd_0s);

    wire [3:0] bcd_1p, bcd_0p;
    bin7_bcd2 mybin2({1'b0,minute},bcd_1p,bcd_0p);
    
    wire [3:0] bcd_1h, bcd_0h;
    bin7_bcd2 mybin3({2'b0,hour},bcd_1h,bcd_0h);
    
    wire [3:0] bcd_1d, bcd_0d;
    bin7_bcd2 mybin4({2'b0,day},bcd_1d,bcd_0d);
    
    wire [3:0] bcd_1m, bcd_0m;
    bin7_bcd2 mybin5({3'b0,month},bcd_1m,bcd_0m);
    
    wire [3:0] bcd_1y, bcd_0y;
    bin7_bcd2 mybin6(year,bcd_1y,bcd_0y);
    
    assign bcd_sel1 = (~switch) ? bcd_0s : bcd_0y;
    assign bcd_sel2 = (~switch) ? bcd_1s : bcd_1y;
    
    assign bcd_sel3 = (~switch) ? bcd_0p : bcd_0m;
    assign bcd_sel4 = (~switch) ? bcd_1p : bcd_1m;
    
    assign bcd_sel5 = (~switch) ? bcd_0h : bcd_0d;
    assign bcd_sel6 = (~switch) ? bcd_1h : bcd_1d;
    
    decode_7seg my7seg1(bcd_sel1,led1);
    decode_7seg my7seg2(bcd_sel2,led2);
    decode_7seg my7seg3(bcd_sel3,led3);
    decode_7seg my7seg4(bcd_sel4,led4);
    decode_7seg my7seg5(bcd_sel5,led5);
    decode_7seg my7seg6(bcd_sel6,led6);
   
endmodule


