	/**************************** BOARD MODULE *************************

	* Assemble all modules out there in a common module...

	*******************************************************************/

	`include "encoder.v"
	`include "decoder.v"
	`include "noise.v"
	`timescale 10ns/1ns

	module bord;

	reg datain,clk,dend,enable;
	reg[3:0] addr1,addr2;
	wire dataout,clk2,donei,noisedata;
	encoder encode(datain,clk,dataout,clk2);
	decoder decode(noisedata,clk2,done);
	noise nois(dataout,clk2,enable,addr1,addr2,noisedata);

	// generate clock(clk) to send data to encoder
	always #2 
		if(~dend) clk = ~clk;

	//send data to encoder
	initial
	begin
		// set "enable" to 1 to induce errors...
		// "addr1" and "addr2" are locations to induce errors at...
		// set both of them to a common value to induce error at that location
		// or set to unique values to induce two-bit errors
		
		enable<=1;addr1<=4'b1100;addr2<=4'b1100;
		
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
		#4 $display("Special bits after encoding: \n parity: %b\n groupwise parity bits: %4b\n",
				encode.mem[0],{encode.mem[1],encode.mem[2],encode.mem[4],encode.mem[8]}); 
		dend<=1;
	end

	// if "done" is set (data decoding done...)
	// display calculated result and stop simulation...
	always @(done)
		if(done)
		begin
			$display("Special parity bits after decoding:\n parity:%b \n groupwise parity bits: %4b\n",
					decode.parity,decode.check);
			if(decode.parity == 1'b0 & decode.check == 4'b0)
				$display("******** No errors detected *********");
			else if(decode.parity == 1'b1 & decode.check != 4'h0)
				$display("!!!!!!! Error detected at %4bth bit !!!!!!!",decode.check);
			else if(decode.parity == 1'b0 & decode.check != 4'h0)
				$display("~~~~~~~~ Two bit error detected...:*\( ~~~~~~~~");
			$finish;
		end

	initial
	begin
		$dumpfile("vars.vcd");
		$dumpvars(0,bord);
	end

	endmodule

