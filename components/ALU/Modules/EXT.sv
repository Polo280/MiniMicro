// EXTEND MODULE 

module UXTB(
	input mode,   					// Mode 0 = byte extend, Mode 1 = halfword extend
	input sign, 					// Sign 0 = Unsigned extend, Sign 1 = Signed extend
	input signed[31:0] num,
	output reg [31:0] extended
);

// Extension Cases 
parameter UXTB = 0,
			 UXTH = 1,
			 SXTB = 2,
			 SXTH = 3;
			 
// Identify current case
reg[1:0] extend_case;

always @(*)
begin
	if(mode == 0 && sign == 0) 
		extend_case = UXTB;
	else if (mode == 1 && sign == 0)
		extend_case = UXTH;
	else if (mode == 0 && sign == 1)
		extend_case = SXTB;
	else 
		extend_case = SXTH;
end 

// Handle different cases 
integer i;
always @(*)
begin 
	case(extend_case)
	UXTB: begin
		for(i = 0; i < 32; i = i + 1) begin
			extended[i] = (i < 8)? num[i] : 0;
		end 
	end 
	UXTH: begin      
		for(i = 0; i < 32; i = i + 1) begin
			extended[i] = (i < 16)? num[i] : 0;
		end 
	end
	SXTB: begin
		  for(i = 0; i < 8; i = i + 1) begin
            extended[i] = num[i];
        end
        for(i = 8; i < 32; i = i + 1) begin
            extended[i] = num[7];
        end 
	end
	SXTH: begin
		for(i = 0; i < 16; i = i + 1) begin
            extended[i] = num[i];
        end
        for(i = 16; i < 32; i = i + 1) begin
            extended[i] = num[15];
        end
	end
	endcase
end 

endmodule 