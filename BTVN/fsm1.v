// fsm1.v (Control Unit)
module fsm1 (
    input clk,
    input reset,
    input [3:0] data_in,
    input cnt_done,
    output reg ack,
    output reg start_cnt,
    output reg [3:0] data_out
);

    parameter IDLE = 2'b00, SEND_DATA = 2'b01, WAIT_DONE = 2'b10, SEND_ACK = 2'b11;
    reg [1:0] state, next_state;

    // FSM state transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // FSM next-state logic (Mealy machine)
    always @(*) begin
        next_state = state; // Default to stay in current state
        start_cnt = 1'b0;
        ack = 1'b0;
        data_out = 4'b0000;

        case (state)
            IDLE: begin
                if (data_in != 4'b0000) begin // Assuming data_in != 0 indicates a new request
                    next_state = SEND_DATA;
                end
            end
            SEND_DATA: begin
                data_out = data_in;
                start_cnt = 1'b1;
                next_state = WAIT_DONE;
            end
            WAIT_DONE: begin
                if (cnt_done) begin
                    next_state = SEND_ACK;
                end
            end
            SEND_ACK: begin
                ack = 1'b1;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

endmodule