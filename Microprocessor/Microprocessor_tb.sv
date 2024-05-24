`timescale 1ns / 1ns

module Microprocessor_tb();

parameter word_size = 32;

// Signals 
reg clock, rst;

// Output
wire out;

// Module instantiation
Microprocessor Micro(
	.clk(clock),
	.rst(rst),
	.output_data(out)
);

// Simulation 
initial begin
	clock = 0;
end


// Clock toggle 
always 
	begin
		#1
		clock = ~clock;
	end
endmodule 