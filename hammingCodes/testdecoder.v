	/******************* TEST-BENCH FOR DECODER MODULE *****************

	* generates test data to test the decoder module

	*******************************************************************/

	`timescale 10ns/1ns
	`include "decoder.v"

	module test;
	reg datain,clk;
	wire done;
	decoder dut(datain,clk,done);

	// generate clock...
	always #2 clk = ~clk;

	// generate test data...
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
		$display("%5b",{dut.parity,dut.check});// $finish;
	end

	// if "done" set, end simulation
	always@ (done)
		if(done)
			$finish;

	initial
	begin
		$dumpfile("vars.vcd");
		$dumpvars(0,test);
	end
	endmodule
