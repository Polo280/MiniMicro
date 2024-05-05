// A ROR module

module ROR(
	input signed [31:0] num,
	input [4:0] shifts,
	output reg [31:0] shifted
);

always @(*) begin
	case(shifts)
	 5'b00000 : shifted = num;
	 5'b00001 : shifted = {num[0], num[31:0]};
	 5'b00010 : shifted = {num[1:0], num[31:2]};
	 5'b00011 : shifted = {num[2:0], num[31:3]};
	 5'b00100 : shifted = {num[3:0], num[31:4]};
	 5'b00101 : shifted = {num[4:0], num[31:5]};
	 5'b00110 : shifted = {num[5:0], num[31:6]};
	 5'b00111 : shifted = {num[6:0], num[31:7]};
	 5'b01000 : shifted = {num[7:0], num[31:8]};
	 5'b01001 : shifted = {num[8:0], num[31:9]};
	 5'b01010 : shifted = {num[9:0], num[31:10]};
	 5'b01011 : shifted = {num[10:0], num[31:11]};
	 5'b01100 : shifted = {num[11:0], num[31:12]};
	 5'b01101 : shifted = {num[12:0], num[31:13]};
	 5'b01110 : shifted = {num[13:0], num[31:14]};
	 5'b01111 : shifted = {num[14:0], num[31:15]};
	 5'b10000 : shifted = {num[15:0], num[31:16]};
	 5'b10001 : shifted = {num[16:0], num[31:17]};
	 5'b10010 : shifted = {num[17:0], num[31:18]};
	 5'b10011 : shifted = {num[18:0], num[31:19]};
	 5'b10100 : shifted = {num[19:0], num[31:20]};
	 5'b10101 : shifted = {num[20:0], num[31:21]};
	 5'b10110 : shifted = {num[21:0], num[31:22]};
	 5'b10111 : shifted = {num[22:0], num[31:23]};
	 5'b11000 : shifted = {num[23:0], num[31:24]};
	 5'b11001 : shifted = {num[24:0], num[31:25]};
	 5'b11010 : shifted = {num[25:0], num[31:26]};
	 5'b11011 : shifted = {num[26:0], num[31:27]};
	 5'b11100 : shifted = {num[27:0], num[31:28]};
	 5'b11101 : shifted = {num[28:0], num[31:29]};
	 5'b11110 : shifted = {num[29:0], num[31:30]};
	 5'b11111 : shifted = {num[30:0], num[0]}; // Shift by 31 bits shifteds in all zeros
	 default : shifted = 32'b0; // Default case forinvalid shift counts
	endcase
end
endmodule 