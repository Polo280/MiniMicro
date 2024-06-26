/*
*	NAME:
* 		regmem
* 
*	DESCRIPTION:
* 		
* 	
* 	PARAMETERS:
* 		
* 	
*
* 	PORTS:
* 		- INPUT:
*					-clk: The clock signal. Data is read from memory on the rising edge of this clock.
*                   -A1, A2: 4 bit addresses for data retrieval
*                   -A3: 4 bit address for either read or write
*                   -WD3: 32 bit Write data Input
*                   -R15: input from Program counter (+ 8)
*                   -WE3: Write enable for address #3

*
* 		- OUTPUTS:
* 	                -RD1, RD2: Return data accessed from A1 and A2
*/


module register_file (
    input clk,          // Clock signal
    input rst,          // Reset Signal
    input [8:0]   A1,   // Read Address 1
    input [8:0]   A2,   // Read Address 2
    input [8:0]   A3,   // Write Address
    input [31:0]  WD3,  // 32-bit write data input (used in writeback)
    input [31:0]  R15,  // Recieved from Program Counter
    input         WE3,  // Write Enable for write back

     //--------------//
     
    output reg [31:0] RD1,  // return data from address 1
    output reg [31:0] RD2   // return data from address 2


);

    /*The 15-element × 32-bit register file holds registers R0–R14 and has
    an additional input to receive R15 from the PC. The register file has
    two read ports and one write port. The read ports take 4-bit address
    inputs, A1 and A2, each specifying one of 2⁴ = 16 registers as source
    operands. They read the 32-bit register values onto read data outputs
    RD1 and RD2, respectively.hj
    
    The write port takes a 4-bit address input,
    A3; a 32-bit write data input, WD3; a write enable input, WE3; and a
    clock. 
    
    
    If the write enable is asserted, then the register file writes the data
    into the specified register on the rising edge of the clock. 
    
    
    A read of R15
    returns the value from the PC plus 8, and writes to R15 must be specially
    handled to update the PC because it is separate from the register file.*/


    // 14+1 register memory
    
    reg [31:0] registers [14:0];
	 reg [31:0] status_register;

    always @(*) 
    begin
        if (rst) begin
		  // Reset registers 
			  registers[0] <= 0;
			  registers[1] <= 0;
			  registers[2] <= 0;
			  registers[3] <= 0;
			  registers[4] <= 0;
			  registers[5] <= 0;
			  registers[6] <= 0;
			  registers[7] <= 0;
			  registers[8] <= 0;
			  registers[9] <= 0;
			  registers[10]<= 0;
			  registers[11]<= 0;
			  registers[12] <= 0;
			  registers[13] <= 0;
			  registers[14] <= 0;
			  status_register <= 0;
			  RD1 <= 0;
			  RD2 <= 0;
        end

        else begin   
				if(WE3) begin
					 /*If the write enable is asserted, then the register file writes the data
					 into the specified register on the rising edge of the clock.*/
					 registers[A3] <= WD3; //Write back semi stage
				end else begin
					registers[A3] <= registers[A3];
				end
				// return values of looked-for addresses
				RD1 <= registers[A1];
				RD2 <= registers[A2]; 
        end
    end
endmodule 