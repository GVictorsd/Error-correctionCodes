	`timescale 10ns/1ns
	`include "decoder.v"

	module test;
	reg datain,clk;
	decoder dut(datain,clk);

	always #2 clk = ~clk;

	initial
	begin
		datain<=0; clk<=0;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=1;
		#4 datain<=0;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=1;
		#4 datain<=1;
		#4 datain<=0;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=1;
		#4 datain<=0;
		#4 $display("%5b",{dut.parity,dut.check}); $finish;
	end

	initial
	begin
		$dumpfile("vars.vcd");
		$dumpvars(0,test);
	end
	endmodule
