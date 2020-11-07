	/************************ NOISE MODULE ***************************

	* used to induce noise during data transmision...
	* input: datain, clock and addr
	* flips the (addr)th bit and outputs data through dataout

	*****************************************************************/

	module noise(
		input datain,clk,
		input[3:0] addr,
		output dataout);
	reg[3:0] count;
	reg neg;

	initial
	begin
		count<= 4'h0;
		neg <= 0;
	end

	assign dataout = neg ? ~datain: datain;

	always@ (negedge clk)
	begin
		if(count == addr)
			neg = 1'b1;
		else
			neg = 1'b0;
		
		count = count + 1;
	end

	endmodule	
