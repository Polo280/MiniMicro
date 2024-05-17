# Mini Micro

A mini microcontroller implemented using FPGA tech


# Instruction Set

An instruction is 32 bit long which contain the necessary information to execute various operations within our RISC ARM-v6 based micro controller. Out of these 32 bits, the first 5 of them are intended to be used as the instruction opcode which identifies the type of operation that will be executed, leaving us with 27 free bits (9 each) which will be distributed equally for specifying destination and source memory addresses for instruction execution.

OPCODE  -  DESTINATION  -  SOURCE 1  -  SOURCE 2

***(example: add first 2 registers and store in 3rd reg)***
00110      000000011       000000000     000000001


# PIPELINE

 - IF (instruction fetch): get the instruction at the PC. 

 - ID (instruction decode): decode the instruction,produce control signals and read register file.

 -  EX (excecute): do calculation .

-  MEM (memory): access memory .

-  WB (write back): write back to register in case the instruction requires it.