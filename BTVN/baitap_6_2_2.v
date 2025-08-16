// Máy trạng thái hữu hạn FSM có 3 trạng thái : IDLE, BUS cycle, ChrgPmp Enable.
// Hoạt động này liên quan đến 1 chu trình của hệ thống sạc và giao tiếp BUS.
// 1. Trạng thái IDLE (Trạng thái chờ):
//	Đây là trạng thái ban đầu của hệ thống. 
// FSM có thể quay trở lại trạng thái này từ trạng thái ChrgPmp Enable khi điều kiện tm_eq_3ms (tg 3ms) và wrt_done (việc ghi đã hoàn thành) đc thoả mãn.
// Tín hiệu rst_n (hoạt động mức thấp) sẽ đưa FSM về trạng thái IDLE.
// 2. Trạng thái BUS cycle (chủ trình BUS):
//	Khi FSM ở trạng thái IDLE và nhận đc tín hiệu wr_eep (viết vào EEPROM) nó sẽ chuyển sang trạng thái BUS cycle.
// Từ trạng thái này, hệ thống sẽ chuyển sang trạng thái ChrgPmp Enable sau khi nhận đc tín hiệu ~clcr_tm (cleartimer - xoá bộ đếm thời gian).
// 3. Trạng thái ChrgPmp Enable (KíCH HOẠT BƠM SẠC): 
// Khi FSM ở trạng thái BUS cycle và nhận đc tín hiệu ~clcr_tm thì nó chuyển ag này. 
//	Nếu điều kiện tm_eq_3ms được đáp ứng, hệ thống sẽ tự động quay trở lại trạng thái ChrgPmp Enable và inc_tm (tăng bộ đếm thời gian) 
// Khi điều kiện tm_eq_3ms và wrt_done được thỏa mãn, hệ thống sẽ trở về trạng thái IDLE, hoàn thành một chu trình. 
module baitap_6_2_2(clk,rst_n,wrt_eep,wrt_data,eep_r_w_n,eep_cs_n,eep_bus,chrg_pmp_en);
	parameter IDLE = 2'b00,BUS = 2'b01,CHRG = 2'b10;
	input clk;
	input rst_n;
	input wrt_eep;
	input [11:0] wrt_data; 
	output eep_r_w_n;
	output eep_cs_n;
	output reg chrg_pmp_en; // giữ trong 3s
	inout [11:0] eep_bus; 
	
	
	reg [13:0] tm; // 3ms => 14 bit timer
	reg clr_tm;		// clear time
	reg inc_tm;
	reg bus_wrt;
	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk or posedge clr_tm) begin
		if(clr_tm) tm <= 14'h0000;
		else if(inc_tm) tm <= tm+1;
	end
	
	assign tm_eq_3ms = (tm == 14'h2EE0)? 1'b1: 1'b0;
	
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) state <= IDLE;
		else state <= next_state; 
	end
	
	always @(state,wrt_eep,tm_eq_3ms) begin
		next_state = IDLE;
		bus_wrt = 0; 
		clr_tm = 0;
		inc_tm = 0; 
		chrg_pmp_en = 0;
		
		case(state)
			IDLE : 
				if(wrt_eep) begin
					next_state = BUS;
				end
			BUS : 
				begin
					clr_tm = 1; 
					bus_wrt = 1;
					next_state = CHRG;
				end
			default:
				begin
					inc_tm = 1;
					chrg_pmp_en = 1;
					if(tm_eq_3ms) begin
						next_state = IDLE;
					end else next_state = CHRG;
				end
		 endcase
	  end
		
		assign eep_r_w_n = ~bus_wrt;
		assign eep_cs_n = ~bus_wrt;
		assign eep_bus = (bus_wrt)? wrt_data : 12'bzzz;
	
endmodule
			
			
	
	
	

