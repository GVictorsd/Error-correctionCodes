	/*********************** ENCODER MODULE **********************

	* Receives data in sync with a clock, calculates the parity of 
	* it and sends the data to the decoder module...

	*************************************************************/

	module encoder(
		input datain,clk,
		output data);
	reg dataout[15:0];
	reg[3:0] addr;
	wire w1;

	initial
	begin
		// initialise variables to known state
		addr <= 4'h0;
		dataout[4'hf] <= 0;
	end

	always@ (posedge clk)
	begin
		// store received data and increment the address
		dataout[addr] = datain;
		addr = addr + 1;
	end

	// calculate parity and assign to w1
	xor g1(w1,datain,dataout[15]);

	always@ (posedge clk)
	begin
		// store calculated parity in a register(at location 0xf)
		dataout[4'hf] = w1;
	end

	endmodule
