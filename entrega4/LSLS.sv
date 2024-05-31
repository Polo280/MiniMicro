module LSLS (
clk ,
num1 ,
num2 , // also interpreted as # imm
result ,
);

input clk ;
input [0:31] num1 , num2;
output reg [0:31] result;

 always @(*) begin
	 case (num2)
	 5'b00000 : result = num1;
	 5'b00001 : result = {num1 [0:30] , 1'b0 };
	 5'b00010 : result = {num1 [0:29] , 2'b00 };
	 5'b00011 : result = {num1 [0:28] , 3'b000 };
	 5'b00100 : result = {num1 [0:27] , 4'b0000 };
	 5'b00101 : result = {num1 [0:26] , 5'b00000 };
	 5'b00110 : result = {num1 [0:25] , 6'b000000 };
	 5'b00111 : result = {num1 [0:24] , 7'b0000000 };
	 5'b01000 : result = {num1 [0:23] , 8'b00000000 };
	 5'b01001 : result = {num1 [0:22] , 9'b000000000 };
	 5'b01010 : result = {num1 [0:21] , 10'b0000000000 };
	 5'b01011 : result = {num1 [0:20] , 11'b00000000000 };
	 5'b01100 : result = {num1 [0:19] , 12'b000000000000 };
	 5'b01101 : result = {num1 [0:18] , 13'b0000000000000 };
	 5'b01110 : result = {num1 [0:17] , 14'b00000000000000 };
	 5'b01111 : result = {num1 [0:16] , 15'b000000000000000 };
	 5'b10000 : result = {num1 [0:15] , 16'b0000000000000000 };
	 5'b10001 : result = {num1 [0:14] , 17'b00000000000000000 };
	 5'b10010 : result = {num1 [0:13] ,18'b000000000000000000 };
	 5'b10011 : result = {num1 [0:12] , 19'b0000000000000000000 };
	 5'b10100 : result = {num1 [0:11] , 20'b00000000000000000000 };
	 5'b10101 : result = {num1 [0:10] , 21'b000000000000000000000 };
	 5'b10110 : result = {num1 [0:9] , 22'b0000000000000000000000 };
	 5'b10111 : result = {num1 [0:8] , 23'b00000000000000000000000 };
	 5'b11000 : result = {num1 [0:7] , 24'b000000000000000000000000 };
	 5'b11001 : result = {num1 [0:6] , 25'b0000000000000000000000000 };
	 5'b11010 : result = {num1 [0:5] , 26'b00000000000000000000000000 };
	 5'b11011 : result = {num1 [0:4] , 27'b000000000000000000000000000 };
	 5'b11100 : result = {num1 [0:3] , 28'b0000000000000000000000000000 };
	 5'b11101 : result = {num1 [0:2] , 29'b00000000000000000000000000000 };
	 5'b11110 : result = {num1 [0:1] , 30'b000000000000000000000000000000 };
	 5'b11111 : result = 32'b0; // Shift by 31 bits results in all zeros
	 default : result = 32'b0; // Default case forinvalid shift counts
	 endcase
 end
 endmodule 