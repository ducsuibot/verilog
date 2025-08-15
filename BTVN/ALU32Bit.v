`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Laboratory 3 (PreLab)
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit (
    input  wire [3:0]  ALUControl,  // Control bits for ALU operation
    input  wire [31:0] A,           // 32-Bit input operand A
    input  wire [31:0] B,           // 32-Bit input operand B
    output reg  [31:0] ALUResult,   // 32-Bit ALU result output
    output reg         Zero         // Zero=1 if ALUResult == 0
);

    // Internal variables for complex operations
    reg [31:0] y;
    integer i;

    // Main combinational logic for ALU operations
    always @(*) begin
        // Default result to prevent latches
        ALUResult = 32'b0;

        case (ALUControl)
            // 0000: AND
            4'b0000: begin
                ALUResult = A & B;
            end

            // 0001: OR
            4'b0001: begin
                ALUResult = A | B;
            end

            // 0010: ADD
            4'b0010: begin
                ALUResult = A + B;
            end
            
            // 0011: NOR
            4'b0011: begin
                ALUResult = ~(A | B);
            end
            
            // 0100: XOR
            4'b0100: begin
                ALUResult = A ^ B;
            end

            // 0101: Sign Extension
            4'b0101: begin
                if (B == 32'd0) begin  // Byte extension
                    if (A[7] == 1) begin
                        ALUResult = {24'hffffff, A[7:0]};
                    end else begin
                        ALUResult = {24'h000000, A[7:0]};
                    end
                end else if (B == 32'd1) begin // Half-word extension
                    if (A[15] == 1) begin
                        ALUResult = {16'hffff, A[15:0]};
                    end else begin
                        ALUResult = {16'h0000, A[15:0]};
                    end
                end else begin
                    ALUResult = A;
                end
            end

            // 0110: SUB (Subtraction)
            4'b0110: begin
                ALUResult = A - B; // Verilog's '-' operator handles 2's complement
            end
            
            // 0111: SLT (Set on Less Than)
            4'b0111: begin
                // Use signed comparison for SLT
                if ($signed(A) < $signed(B)) begin
                    ALUResult = 32'd1;
                end else begin
                    ALUResult = 32'd0;
                end
            end

            // 1001: MUL (Multiply)
            4'b1001: begin
                ALUResult = A * B;
            end

            // 1010: SLL (Shift Left Logical)
            4'b1010: begin
                ALUResult = A << B;
            end

            // 1011: SGT (Set Greater Than)
            4'b1011: begin
                if ($signed(A) > $signed(B)) begin
                    ALUResult = 32'd1;
                end else begin
                    ALUResult = 32'd0;
                end
            end

            // 1100: CLO/CLZ (Count Leading Zeros/Ones)
            4'b1100: begin
                // Counting leading zeros (assuming B is the value to check against)
                // This implementation seems a bit ambiguous based on the original code
                // A more standard implementation for CLZ would look like this:
                integer count = 0;
                for (i = 31; i >= 0; i = i - 1) begin
                    if (A[i] == 1'b0) begin
                        count = count + 1;
                    end else begin
                        i = -1; // Exit loop
                    end
                end
                ALUResult = count;
            end
            
            // 1101: ROTR & SRL (Rotate Right & Shift Right Logical)
            4'b1101: begin
                y = A;
                for (i = 0; i < B[4:0]; i = i + 1) begin
                    if (B[5] == 1'b1) begin // ROTR
                        y = {y[0], y[31:1]};
                    end else begin // SRL
                        y = {1'b0, y[31:1]};
                    end
                end
                ALUResult = y;
            end
            
            // 1110: SLTU (Set Less Than Unsigned)
            4'b1110: begin
                if (A < B) begin
                    ALUResult = 32'd1;
                end else begin
                    ALUResult = 32'd0;
                end
            end

            // 1111: SRA (Shift Right Arithmetic)
            4'b1111: begin
                ALUResult = $signed(A) >>> B;
            end
            
            default: begin
                ALUResult = 32'b0;
            end
        endcase
    end

    // Separate combinational logic for the Zero flag
    always @(ALUResult) begin
        if (ALUResult == 32'd0) begin
            Zero = 1'b1;
        end else begin
            Zero = 1'b0;
        end
    end

endmodule