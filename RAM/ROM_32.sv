/*
*	NAME:
* 		ROM_32
* 
*	DESCRIPTION:
* 		This module implements a 32-bit Read-Only Memory with a parameterizable 
* 		data width and memory depth. The ROM reads data from a specified address 
* 		on the rising edge of the clock.
*		The initial contents of the memory are loaded from an external file.
* 	
* 	PARAMETERS:
* 		- data_length: The width of the data bus (default is 32 bits).
* 		- mem_length: The depth of the memory, i.e., the number of memory locations 
* 		  (default is 32).
* 	
*
* 	PORTS:
* 		- INPUT:
*					-clk: The clock signal. Data is read from memory on the rising edge of this clock.
*
* 				 	-address: The address input to specify which memory location 
* 		                          to read. The width of this port is determined by 
* 		                          the logarithm of the memory depth.
*
* 		- OUTPUTS:
*                	 -return_data: The data output that holds the value read from the memory.
* 	
*/




module ROM_32 #(parameter data_length = 32, parameter mem_length = 32)(

input clk,										// clock
input [$clog2(mem_length)-1:0] address, 		// address to read
output reg [data_length-1:0]   return_data 	    // data output 
);

reg [data_length-1:0] mem [0:mem_length-1];

/* Initialized values from file 

initial
begin
	$readmemh("instructions.mem", mem); 		// intializes values into memory
end

*/
// Or initialize from code, better for testing
mem[0] = 00110000000011000000000000000001; // add whatever is in reg 0 and reg 1, store on reg 3


always @(posedge clk)
begin 
		rdata <= mem[addr];	
end 
endmodule 