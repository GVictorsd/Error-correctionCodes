	`timescale 10ns/1ns
	`include "encoder.v"

	module test;
	reg datain,clk;
	wire dataout,clkout;
	encoder dut(datain,clk,dataout,clkout);

	always #2 clk = ~clk;

	initial
	begin
		datain<=0; clk<=0;
		#4 datain<=0;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=0;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=1;
		#4 datain<=0;
		#4 datain<=0;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=1;
		#4 datain<=0;
		#4 $display("%5b",{dut.mem[0],dut.mem[1],dut.mem[2],dut.mem[4],dut.mem[8]}); $finish;
	end

	initial
	begin
		$dumpfile("vars.vcd");
		$dumpvars(0,test);
	end
	endmodule
