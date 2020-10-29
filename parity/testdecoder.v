	`timescale 10ns/1ns
	`include "decoder.v"

	module test;
	reg datain,clk;
	wire data,res;
	decoder dut(datain,clk,data,res);

	always #2 clk = ~clk;

	initial
	begin
		datain = 0; clk = 0;
		#4 datain = 0;
		#4 datain = 1;
		#4 datain = 0;
		#4 datain = 1;
		#4 datain = 1;
		#4 datain = 0;
		#4 datain = 1;
		#4 datain = 0;
		#4 datain = 0;
		#4 datain = 1;
		#4 datain = 1;
		#4 datain = 0;
		#4 datain = 1;
		#4 datain = 0;
		#4 datain = 0;
		#4 $display("%b",dut.res); $finish;
	end

	initial
	begin
		$dumpfile("vars.vcd");
		$dumpvars(0,test);
	end

	endmodule
