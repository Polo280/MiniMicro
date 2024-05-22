/*
*	NAME:
* 		RAM
* 
*	DESCRIPTION:
* 		This module implements a Random Access Memory with a parameterizable data width 
* 		and memory depth. The RAM reads/writes data to/from a specified address on the rising
* 		edge of the clock. (r/w is controlled by the write enable flag)
*		
* 	
* 	PARAMETERS:
* 		- DATA_LENGTH: The width of the data bus (default is 32 bits).
* 		- MEM_LENGHT:  The depth of the memory, i.e., the number of memory locations 
* 		  				default is 32).
* 	
*
* 	PORTS:
* 		- INPUT:
*					-clk: The clock signal - Data is read from memory on the rising edge of this clock.
*					-rst: reset signal - clear all memory
* 				 	-we:  Write enable - when high, data is written to specified memory address
*					-address: Memory location to access 
*     				-write_data: Data to be written 
*                   
* 		- OUTPUTS:
*                	-read_data:  Data to be returned
* 	
*/


module RAM #(parameter data_length = 32,
			 parameter mem_length = 32)
(
	input clk,										// clock
	input rst										// reset
	input we, 										// read - write mode : 0 = read, 1 = write
	input [$clog2(mem_length)-1:0] address, 		// address bus
	input [data_length-1:0] write_data, 			// input data

	output reg [data_length-1:0] read_data 			// data output 
);




reg [data_length-1:0] mem [0:mem_length-1];	// actual memory




always @(posedge clk or posedge rst)
begin 
	if (rst)
	begin
		// Reset memory to all zeros
		integer i;
		for (i = 0; i < mem_length; i = i + 1)
			mem[i] <= 0;
	end
	
	else
	begin
		if(we) // check write enable flag
		begin
			// if flag is high, write data
			mem[address] <= write_data;
		end
		else
			read_data <= mem[address];	
	end
end 

endmodule