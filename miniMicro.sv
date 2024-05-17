/*
    Instruction Set

    #####         | ### ### ###         |  ### ### ###         | ### ### ###         |
    OPCODE (5bits)| Destination (9bits) |  Source 1 (5bits)    | Source 2 (9bits)    | 


    ANDS = 1	  | Bitwise AND
	ORRS = 2	  | Bitwise OR 
	MVNS = 3	  | Bitwise NOT
	EORS = 4	  | Bitwise XOR 
	
	    - Arithmetic operations -

	ADCS = 5	  | Add with carry
	ADDS = 6	  | Normal addition
	SBCS = 7	  | Subtraction with carry
	SUB  = 8	  | Subtraction
	MULS = 9      | Multiplication

	          - Shifts -

	LSRS = 10	  | Logic Shift Right 
	LSLS = 11	  | Logic Shift Left 
	ASR  = 12	  | Arithmetic right shift (arithmetic left is the same as logic left)
	
	        - Rotates- 
	ROR  = 13     | Rotate right 
	
	         - Extends -
	UXTB = 14     | Unsigned extend byte 
	UXTH = 15	  | Unsigned extend halfword 
	SXTB = 16	  | Signed extend byte 
	SXTH = 17	  | Signed extend halfword 
	
	- Other instructions -
	CMP  = 18	  | Compare 


*/



/* IF (instruction fetch): get the instruction at the PC */
/* ID (instruction decode): decode the instruction,produce control signals and read register file */
/* EX (excecute): do calculation */
/* MEM (memory): access memory */
/* WB (write back): write back to register */