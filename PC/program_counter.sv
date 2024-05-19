
module program_counter (
    input clk,
    input rst
    output [31:0] pc_out
);    // ... other declarations

    
    reg [31:0] PC;

    always @(posedge clk) begin
        if (rst) 
        begin
            PC <= 32'h0; // Reset PC to initial address
        end 
        else 
        begin
            PC <= PC + 4; // Increment PC by instruction width (32-bit)
        end
    end


endmodule
