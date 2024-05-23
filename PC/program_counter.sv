
module program_counter (
    input clk,
    input rst
    output [31:0] pc_out
);   


    always @(posedge clk) begin
        if (rst) 
        begin
            pc_out <= 32'h0; // Reset PC to initial address
        end 
        else 
        begin
            pc_out <= pc_out + 4; // Increment PC by instruction width (32-bit)
        end
    end


endmodule
