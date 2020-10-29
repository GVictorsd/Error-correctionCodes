	module encoder(
		input datain,clk,
		output data);
	reg dataout[15:0];
	reg[3:0] addr;
	wire w1;

	initial
	begin
		addr <= 4'h0;
		dataout[4'hf] <= 0;
	end

	always@ (posedge clk)
	begin
		dataout[addr] = datain;
		addr = addr + 1;
	end

	xor g1(w1,datain,dataout[15]);

	always@ (posedge clk)
	begin
		dataout[4'hf] = w1;
	end

	endmodule
