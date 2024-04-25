module Booth(
    input signed [31:0] M, Q,   // Multiplicand, multiplier
    output reg signed [63:0] result
);

reg [31:0] AC = 0;              // Accumulator, initialized to zero
reg [32:0] QR;      				// Multiplier Q and an extra bit Q_(-1)
reg [31:0] MQ;              // Local copy of M to use in operations

initial begin
	QR = {Q, 1'b0};
	MQ = M;
end

integer i;
// Logic to handle addition, subtraction, and shifting
always @(*) begin
    for (i = 0; i < 32; i = i + 1) begin
        case (QR[1:0])  // Examine the least significant two bits
            2'b01: begin
                AC = AC + MQ;  // Add M to AC if Q0, Q-1 is 01
            end
            2'b10: begin
                AC = AC - MQ; 
            end
        endcase
        // Arithmetic right shift of
        {AC, QR} = {AC[31], AC, QR} >> 1;  // Concatenate AC and QR, then shift right
    end
    result = {AC, QR[31:1]};
end

endmodule
