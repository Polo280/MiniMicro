/*
*	NAME:
* 		control_unit
* 
*	DESCRIPTION:
* 		This module decodes the instruction recieved from program mem.
*       extracts the opcode, destination, source 1, source 2 and determines
*       if the instruction requieres the use of the ALU
* 	
* 	PARAMETERS:
*       -
*
* 	
*
* 	PORTS:
* 		- INPUT:
*					-clk: The clock signal. Data is read from memory on the rising edge of this clock.
*
* 				 	-instruction: 32 bit instruction recieved from program mem
*
* 		- OUTPUTS:
*                	 -opcode:       bits 0  to 4 (MSB,from left to right)
*                    -destination:  bits 5  to 13
*                    -source_1:     bits 14 to 22
*                    -source_2:     bits 23 to 31
*                    -is_alu_flag:  flag to tell CPU if instruction must be sent to ALU
* 	
*/


module control_unit #()
(
    input clk,
    input [INSTRUCTION_WIDTH-1 : 0] instruction

    output [4:0] opcode,
    output [8:0] destination,
    output [8:0] source_1,
    output [8:0] source_2,
    output is_alu_flag
);


always @(posedge clk )
begin
    //separate instruction into its components
    opcode      = instruction[31:27];
    destination = instruction[26:18];    
    source_1    = instruction[17:9];    
    source_2    = instruction[8:0];

    //check if instruction is ALU instruction
    if( instruction > 0 && instruction < 20)
        is_alu_flag = 1;
    else
        is_alu_flag = 0;    
end





    
endmodule