	/**************************** BOARD MODULE *************************

	* Assemble all modules out there in a common module...

	*******************************************************************/

	`include "encoder.v"
	`include "decoder.v"
	`timescale 10ns/1ns

	module bord;

	reg datain,clk,dend;
	wire dataout,clk2,done;
	encoder encode(datain,clk,dataout,clk2);
	decoder decode(dataout,clk2,done);

	// generate clock(clk) to send data to encoder
	always #2 
		if(~dend) clk = ~clk;

	//send data to encoder
	initial
	begin
		clk<=0; dend<=0;
		   datain<=0;	// special bit always set to 0
		#4 datain<=0;	// special bit always set to 0
		#4 datain<=0;	// special bit always set to 0
		#4 datain<=0;
		#4 datain<=0;	// special bit always set to 0
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=1;
		#4 datain<=0;	// special bit always set to 0
		#4 datain<=0;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=0;
		#4 datain<=1;
		#4 datain<=1;
		#4 datain<=0;
		// display special bits after encoding...
		#4 $display("%5b",{encode.mem[0],encode.mem[1],encode.mem[2],encode.mem[4],encode.mem[8]}); dend<=1;
	end

	// if "done" is set (data decoding done...)
	// display calculated result and stop simulation...
	always @(done)
		if(done)
		begin
			$display("%5b",{decode.parity,decode.check});
			$finish;
		end
	endmodule