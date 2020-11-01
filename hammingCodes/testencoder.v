	/*************************** TEST-BENCH FOR ENCODER *********************

	* generates test data to test the encoder module

	************************************************************************/

	`timescale 10ns/1ns
	`include "encoder.v"

	module test;
	reg datain,clk,done;
	wire dataout,clkout;
	encoder dut(datain,clk,dataout,clkout);

	// generate clock(clk)...
	always #2 
		if(~done) clk = ~clk;

	// generate test data...
	initial
	begin
		datain<=0; clk<=0; done<=0;
		#4 datain<=0;
		#4 datain<=0;
		#4 datain<=0;
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
		#4 $display("%5b",{dut.mem[0],dut.mem[1],dut.mem[2],dut.mem[4],dut.mem[8]}); done<=1;
		#4 $finish;
	end

	initial
	begin
		$dumpfile("vars.vcd");
		$dumpvars(0,test);
	end
	endmodule
