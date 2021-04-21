	/************************ NOISE MODULE ***************************

	* used to induce noise during data transmision...
	* input: datain, clock, enable, addr1 and addr2
	* flips (addr1 and addr2)th bit if enable is set 
	* and outputs data through dataout

	*****************************************************************/

	module noise(
		input datain,clk,enable,
		input[3:0] addr1,addr2,
		output dataout);
	reg[3:0] count;
	reg neg;

	initial
	begin
		count<= 4'h0;
		neg <= 0;
	end

	assign dataout = neg ? ~datain: datain;

	// Display input and output bits...
	always@ (clk)begin
		$display("%b, %b ,%b", datain, dataout, ~clk);
	end

	always@ (negedge clk)
	begin
		if((count == addr1 | count == addr2) & enable)
			neg = 1'b1;
		else
			neg = 1'b0;
		
		count = count + 1;
	end

	endmodule	
