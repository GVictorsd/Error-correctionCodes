	`timescale 10ns/1ns
	`include "encoder.v"

	module test;
	reg datain,clk;
	wire data;
	encoder dut(datain,clk,data);

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
		#4 datain = 0;
		#4 datain = 1;
		#4 datain = 1;
		#4 datain = 1;
		#4 $display("%b",dut.dataout[4'hf]); $finish;
	end

	initial
	begin
		$dumpfile("vars.vcd");
		$dumpvars(0,test);
	end

	endmodule
