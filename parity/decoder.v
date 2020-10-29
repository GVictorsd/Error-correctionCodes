	module decoder(
		input datain,clk,
		output data,res);
	reg dataout[15:0];
	reg[3:0] addr;
	reg check;
	wire w1;

	initial
	begin
		addr <= 4'h0;
//		dataout[4'hf] <= 0;
		check <= 0;
	end

	always@ (posedge clk)
	begin
		dataout[addr] = datain;
		addr = addr + 1;
	end

	xor g1(w1,datain,check);

	always@ (posedge clk)
	begin
		check = w1;
	end

	assign res = (check == dataout[4'hf]) ? 1 : 0;

	endmodule
