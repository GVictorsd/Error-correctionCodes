	/*********************** DECODER MODULE *************************

	* Reads encoded data from the encoder and checks for any errors
	* serial data is received in sync with a clock (clk)...

	****************************************************************/

	module decoder(
		input datain,clk,
		output reg done);

	reg mem[15:0];
	reg[3:0] addr, check;
	reg parity;
	wire w1,w2,w3,w4,w5;

	// initialize variables to known state
	initial
	begin
		addr <= 4'h0;
		parity <= 0;
		check <= 4'h0;
	end

	// read and store transmited data in memory(mem)
	always@ (posedge clk)
	begin
		mem[addr] = datain;
		{done,addr} = addr + 1;
	end

	// calculate special parity bits to compare at the end
	assign w1 = datain ^ parity;
	assign w2 = (datain & addr[0]) ^ check[0];
	assign w3 = (datain & addr[1]) ^ check[1];
	assign w4 = (datain & addr[2]) ^ check[2];
	assign w5 = (datain & addr[3]) ^ check[3];

	// store calculated parity bits...
	always@ (posedge clk)
	begin
		parity <= w1;
		check[0] <= w2;
		check[1] <= w3;
		check[2] <= w4;
		check[3] <= w5;
	end
	
	endmodule
