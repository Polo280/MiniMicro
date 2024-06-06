`timescale 1ns / 1ns
module load_tb();

reg clock, rst;
wire [31:0] datamemory, instruction, outALU, srctest1, srctest2, RD1test, RD2test, RA3test, RWD3test, datamem_addr, current_inst;
wire [5:0] inputALU, pc_out;
wire writeReg, mem_to_regtest;

Microprocessor Micro(
	.clk(clock),
	.rst(rst),
	.output_data(datamemory),
	.tester(instruction),
	.current_inst(current_inst),
	.outALU(outALU),
	.inputALU(inputALU),
	.srctest1(srctest1),
	.srctest2(srctest2),
	.RD1test(RD1test),
	.RD2test(RD2test),
	.RA3test(RA3test),
	.RWD3test(RWD3test),
	.datamem_addr(datamem_addr),
	.writeReg(writeReg),
	.mem_to_regtest(mem_to_regtest),
	.pctest(pc_out)
);

initial begin
	clock = 1;
	rst = 1;
	#4
	rst = 0;
	#8
	$Stop;
end

always
	begin
		#1
		clock = ~clock;
	end

endmodule 