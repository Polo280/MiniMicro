module Memory # (parameter data_length = 8, parameter mem_length = 64)(
input rst,  											// Reset block to start with initial known values 
input [data_length-1:0] wdata, 					// Data to be written into memory (Write data bus)
input clk,												// Clock to syncrhonize 	
input we, 												// Read - write mode : 0 = write, 1 = read
input [$clog2(mem_length)-1:0] addr, 			// Address bus
output reg [data_length-1:0] rdata 				// Read data bus 
);

// 64 different memory locations 
// 6 bits for identifying each location 
// 9 bit instructions 

reg [data_length-1:0] mem [0:mem_length-1];

/* Initialized values from file 

initial
begin
	$readmemh("instructions.mem", mem); 		// intializes values into memory
end

*/

//mem[0][0] = 8'b00110111; // add whatever is in reg 0 and reg 1, store on reg 3


always @(posedge clk or posedge rst)
begin 
	// Manage initial conditions 
	if(rst) begin
		mem[0][0] = 8'b00110111;
	end else 
	begin 
		// Identify read or write mode 
		if(!we)
		begin
			mem[addr] <= wdata;  // Update internal storage cell with the write data bus value
		end
		else
			rdata <= mem[addr];	// Update read data bus output with data stored in address cell 
		end 
	end
endmodule 