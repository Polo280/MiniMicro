module ram_32 # (parameter data_length = 32, parameter mem_length = 32)(
input [data_length-1:0] wdata, 					// input data
input clk,										// clock 	
input we, 										// read - write mode : 0 = write, 1 = read
input [$clog2(mem_length)-1:0] addr, 			// address bus
output reg [data_length-1:0] rdata 				// data output 
);

reg [data_length-1:0] mem [0:mem_length-1];

/* Initialized values from file 

initial
begin
	$readmemh("instructions.mem", mem); 		// intializes values into memory
end

*/

mem[0] = 00110000000011000000000000000001; // add whatever is in reg 0 and reg 1, store on reg 3




always @(posedge clk)
begin 
	if(!we)
	begin
		mem[addr] <= wdata;
	end
	else
		rdata <= mem[addr];	
end 
endmodule 