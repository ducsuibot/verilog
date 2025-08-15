// 6.2.1 khái niệm
// FSM đc triển khai bằng mạch logic tuần tự gồm 2 khối cơ bản
// Khối 1: Logic tổ hợp mô tả trạng thái kế tiếp và hàm đàu ra.
// Khối 2: Khối Flip Flop lưu trữ trạng thái hiện tại của mạch.
// FSM được mô tả bằng đồ thị chuyển trạng thái
// 6.2.2 Mô tả FSM trong verilog
// Mô tả logic tổ hợp và FF riêng rẽ 
// Logic tổ hợpđược mô tả bằng khối always và phép gán blocking , dùng lệnh case, mỗi case là 1 trạng thái
// FF được mô tả bằng khối always có đồng hồ và phép gán non blocking.
// 6.2.1
// fsm
module baitap_6_2_1 (clk,reset,a,b,Y,Z,state,next_state);
	input clk,reset,a,b;
	output reg Y,Z;
	localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
	output reg[1:0] state,next_state;
	
	always @(posedge clk,posedge reset) begin
		if(reset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state,a,b) begin 
		Y = 1'b0;
		Z = 1'b0;
		case(state)
			S0: if(a) begin
					next_state = S1;
					Z = 1;
				 end else begin
					next_state = S0; 
				 end
			S1: begin
					Y = 1;
					if(b) begin
						next_state = S2;
						Z = 1;
					end else begin
						next_state = S1;
					end 
				 end
			S2: next_state = S0;
		 endcase
	end
endmodule

// Mô tả hoạt động.
// 1. Khởi tạo : Khi reset=1 thì FSM sẽ được đặt lại về trạng thái S0.
// 2. Từ S0: 
//				+ Nếu đầu vào a = 0 thì FSM vẫn ở trạng thái S0.
// 			+ Nếu đầu vào a = 1 thì FSM chuyển sang trạng thái S1. Đâu ra Z = 1.
// 3. Từ S1:  
//				+ Néu đầu vào a = 0 hoặc a = 1 hoặc b = 0 thì FSM vẫn ở trạng thái S1. Đầu ra Y =1 
// 			+ Nếu đầu vào b = 1 thì FSM chuyển sang trạng thái S2. Đầu ra Z = 1 và Y = 1
// 4. Từ S2: 
//				+ FSM sẽ tự động chuyển từ trạng thái S2 về trạng thái S0.