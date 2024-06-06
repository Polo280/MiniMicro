module Memory # (parameter data_length = 32, parameter mem_length = 64)(
input clk,												// Clock to synchronize 	
input rst,  											// Reset block to start with initial known values 
input [data_length-1:0] wdata, 					// Data to be written into memory (Write data bus)
input we, 												// Read - write mode : 0 = READ, 1 = WRITE
input [$clog2(mem_length)-1:0] addr, 			// Address bus

output reg [data_length-1:0] rdata 				// Read(return) data bus 
);

// 32 different memory locations 
// 9 bits for identifying each location 
// 5 bit instructions 


//create actual memory
reg [data_length-1:0] mem [mem_length-1:0];

always @(posedge clk or posedge rst)
begin 
	// Clear memory on rst
	if(rst) 
	begin
		mem[0] <= 254;
		mem[1] <= 1;
		mem[2] <= 2;
		mem[3] <= 3;
		mem[4] <= 4;
		mem[5] <= 5;
		mem[6] <= 6;
		mem[7] <= 7;
		mem[8] <= 8;
		mem[9] <= 9;
		mem[10] <= 10;
		mem[11] <= 11;
		mem[12] <= 12;
		mem[13] <= 13;
		mem[14] <= 14;
		mem[15] <= 15;
		mem[16] <= 16;
		mem[17] <= 17;
		mem[18] <= 18;
		mem[19] <= 19;
		mem[20] <= 20;
		mem[21] <= 21;
		mem[22] <= 22;
		mem[23] <= 23;
		mem[24] <= 24;
		mem[25] <= 25;
		mem[26] <= 26;
		mem[27] <= 27;
		mem[28] <= 28;
		mem[29] <= 29;
		mem[30] <= 30;
		mem[31] <= 31;
		mem[32] <= 32;
		mem[33] <= 33;
		mem[34] <= 34;
		mem[35] <= 35;
		mem[36] <= 36;
		mem[37] <= 37;
		mem[38] <= 38;
		mem[39] <= 39;
		mem[40] <= 40;
		mem[41] <= 41;
		mem[42] <= 42;
		mem[43] <= 43;
		mem[44] <= 44;
		mem[45] <= 45;
		mem[46] <= 46;
		mem[47] <= 47;
		mem[48] <= 48;
		mem[49] <= 49;
		mem[50] <= 50;
		mem[51] <= 51;
		mem[52] <= 52;
		mem[53] <= 53;
		mem[54] <= 54;
		mem[55] <= 55;
		mem[56] <= 56;
		mem[57] <= 57;
		mem[58] <= 58;
		mem[59] <= 59;
		mem[60] <= 60;
		mem[61] <= 61;
		mem[62] <= 62;
		mem[63] <= 63;
		rdata <= 0;
	end else begin 
		if(addr < mem_length) begin
			rdata <= mem[addr];	// Update read data bus output with data stored in address cell 
			// Identify read or write mode 
			if(we) begin
				mem[addr] <= wdata;  // Update internal storage cell with the write data bus value
			end
		end else begin  // If address is out of memory index set output to a number 
			rdata <= 255;
		end 
	end
end
endmodule 