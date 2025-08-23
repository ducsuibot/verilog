`timescale 1ns / 1ps
module bin7_bcd2(
    input  [6:0] bin,        
    output reg [3:0] bcd1,   // Chuc
    output reg [3:0] bcd0    // Don vi
);

    always @(*) begin
        case(bin)
            7'd0 : {bcd1,bcd0} = 8'h00; 7'd1 : {bcd1,bcd0} = 8'h01;
            7'd2 : {bcd1,bcd0} = 8'h02; 7'd3 : {bcd1,bcd0} = 8'h03;
            7'd4 : {bcd1,bcd0} = 8'h04; 7'd5 : {bcd1,bcd0} = 8'h05;
            7'd6 : {bcd1,bcd0} = 8'h06; 7'd7 : {bcd1,bcd0} = 8'h07;
            7'd8 : {bcd1,bcd0} = 8'h08; 7'd9 : {bcd1,bcd0} = 8'h09;
            7'd10: {bcd1,bcd0} = 8'h10; 7'd11: {bcd1,bcd0} = 8'h11;
            7'd12: {bcd1,bcd0} = 8'h12; 7'd13: {bcd1,bcd0} = 8'h13;
            7'd14: {bcd1,bcd0} = 8'h14; 7'd15: {bcd1,bcd0} = 8'h15;
            7'd16: {bcd1,bcd0} = 8'h16; 7'd17: {bcd1,bcd0} = 8'h17;
            7'd18: {bcd1,bcd0} = 8'h18; 7'd19: {bcd1,bcd0} = 8'h19;
            7'd20: {bcd1,bcd0} = 8'h20; 7'd21: {bcd1,bcd0} = 8'h21;
            7'd22: {bcd1,bcd0} = 8'h22; 7'd23: {bcd1,bcd0} = 8'h23;
            7'd24: {bcd1,bcd0} = 8'h24; 7'd25: {bcd1,bcd0} = 8'h25;
            7'd26: {bcd1,bcd0} = 8'h26; 7'd27: {bcd1,bcd0} = 8'h27;
            7'd28: {bcd1,bcd0} = 8'h28; 7'd29: {bcd1,bcd0} = 8'h29;
            7'd30: {bcd1,bcd0} = 8'h30; 7'd31: {bcd1,bcd0} = 8'h31;
            7'd32: {bcd1,bcd0} = 8'h32; 7'd33: {bcd1,bcd0} = 8'h33;
            7'd34: {bcd1,bcd0} = 8'h34; 7'd35: {bcd1,bcd0} = 8'h35;
            7'd36: {bcd1,bcd0} = 8'h36; 7'd37: {bcd1,bcd0} = 8'h37;
            7'd38: {bcd1,bcd0} = 8'h38; 7'd39: {bcd1,bcd0} = 8'h39;
            7'd40: {bcd1,bcd0} = 8'h40; 7'd41: {bcd1,bcd0} = 8'h41;
            7'd42: {bcd1,bcd0} = 8'h42; 7'd43: {bcd1,bcd0} = 8'h43;
            7'd44: {bcd1,bcd0} = 8'h44; 7'd45: {bcd1,bcd0} = 8'h45;
            7'd46: {bcd1,bcd0} = 8'h46; 7'd47: {bcd1,bcd0} = 8'h47;
            7'd48: {bcd1,bcd0} = 8'h48; 7'd49: {bcd1,bcd0} = 8'h49;
            7'd50: {bcd1,bcd0} = 8'h50; 7'd51: {bcd1,bcd0} = 8'h51;
            7'd52: {bcd1,bcd0} = 8'h52; 7'd53: {bcd1,bcd0} = 8'h53;
            7'd54: {bcd1,bcd0} = 8'h54; 7'd55: {bcd1,bcd0} = 8'h55;
            7'd56: {bcd1,bcd0} = 8'h56; 7'd57: {bcd1,bcd0} = 8'h57;
            7'd58: {bcd1,bcd0} = 8'h58; 7'd59: {bcd1,bcd0} = 8'h59;
            7'd60: {bcd1,bcd0} = 8'h60; 7'd61: {bcd1,bcd0} = 8'h61;
            7'd62: {bcd1,bcd0} = 8'h62; 7'd63: {bcd1,bcd0} = 8'h63;
            7'd64: {bcd1,bcd0} = 8'h64; 7'd65: {bcd1,bcd0} = 8'h65;
            7'd66: {bcd1,bcd0} = 8'h66; 7'd67: {bcd1,bcd0} = 8'h67;
            7'd68: {bcd1,bcd0} = 8'h68; 7'd69: {bcd1,bcd0} = 8'h69;
            7'd70: {bcd1,bcd0} = 8'h70; 7'd71: {bcd1,bcd0} = 8'h71;
            7'd72: {bcd1,bcd0} = 8'h72; 7'd73: {bcd1,bcd0} = 8'h73;
            7'd74: {bcd1,bcd0} = 8'h74; 7'd75: {bcd1,bcd0} = 8'h75;
            7'd76: {bcd1,bcd0} = 8'h76; 7'd77: {bcd1,bcd0} = 8'h77;
            7'd78: {bcd1,bcd0} = 8'h78; 7'd79: {bcd1,bcd0} = 8'h79;
            7'd80: {bcd1,bcd0} = 8'h80; 7'd81: {bcd1,bcd0} = 8'h81;
            7'd82: {bcd1,bcd0} = 8'h82; 7'd83: {bcd1,bcd0} = 8'h83;
            7'd84: {bcd1,bcd0} = 8'h84; 7'd85: {bcd1,bcd0} = 8'h85;
            7'd86: {bcd1,bcd0} = 8'h86; 7'd87: {bcd1,bcd0} = 8'h87;
            7'd88: {bcd1,bcd0} = 8'h88; 7'd89: {bcd1,bcd0} = 8'h89;
            7'd90: {bcd1,bcd0} = 8'h90; 7'd91: {bcd1,bcd0} = 8'h91;
            7'd92: {bcd1,bcd0} = 8'h92; 7'd93: {bcd1,bcd0} = 8'h93;
            7'd94: {bcd1,bcd0} = 8'h94; 7'd95: {bcd1,bcd0} = 8'h95;
            7'd96: {bcd1,bcd0} = 8'h96; 7'd97: {bcd1,bcd0} = 8'h97;
            7'd98: {bcd1,bcd0} = 8'h98; 7'd99: {bcd1,bcd0} = 8'h99;
            default: {bcd1,bcd0} = 8'h00;
        endcase
    end
endmodule
