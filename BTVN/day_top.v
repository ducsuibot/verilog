module day_top(
  input clk_5hz, inc_d, rst_n,  
  input enable,           //Enable chinh tang giam 
  input up ,down,
  output wire inc_mon, 
  output wire [4:0] day
);
  wire [4:0] set_day;
  cnt_day cnt_day1(clk_5hz, inc_d, rst_n, set_day, enable, up, down, inc_mon, day);

  wire [7:0] year;
  wire [4:0] month;
  cnt_12m cnt_12m1(.month(month));
  cnt_year cnt_year1(.year(year));

  wire [1:0] year_lsb;
  assign year_lsb = year[1:0];
  day_mon day_mon1(.month(month), .year_lsb(year_lsb), .set_day(set_day));
endmodule
