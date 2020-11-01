	/************************* ENCODER MODULE ******************************

	* Takes data to be encoded from its test module (testencoder) and 
	* encodes the data ie, sets the special parity bits. Data transfer
	* is done in sync with a clk input(synchronus serial data transfer)
	* After encoding, outputs data in a similar way via dataout and clkout

	************************************************************************/

	`timescale 10ns/1ns

	module encoder(
		input datain, clk,
		output dataout,
		output clk2);

	reg mem[15:0];
	reg[3:0] addr,addrout;
	reg parity,clkout,encoded,sent;

	wire w1,w2,w3,w4,w5;

	assign clk2 = clkout;
	
	// initialize variables...
	initial
	begin
		addr<=4'h0; sent<=0;
		parity<=0;  mem[0]<=0;
		mem[1]<=0;  mem[2]<=0;
		mem[4]<=0;  mem[8]<=0;
		encoded<=0; clkout<=0;
		addrout<=4'h0;
	end

	/********************* reading and storing data ***********************/

	// read and store input data in memory(mem)
	// at incremental memory locations
	always@ (posedge clk)
	begin
		mem[addr] = datain;
		{encoded,addr} = addr + 1;
		// once addr reached 0xf, further incrementing 
		// causes overflow (addr goes to 0x0 and encoder is set)
		// indicating reading done...
	end

	// calculating specific parity bits...
	assign w1 = datain ^ parity;
	assign w2 = (datain & addr[0]) ^ mem[1];
	assign w3 = (datain & addr[1]) ^ mem[2];
	assign w4 = (datain & addr[2]) ^ mem[4];
	assign w5 = (datain & addr[3]) ^ mem[8];

	// store calculated parity bits in their respective
	// locations
	always@ (posedge clk)
	begin
		parity <= w1;
		mem[1] <= w2;
		mem[2] <= w3;
		mem[4] <= w4;
		mem[8] <= w5;
	end

	always@ (negedge clk)
	begin
		mem[0] <= parity ^ (mem[1] ^ mem[2] ^ mem[4] ^ mem[8]);
	end

	/*********************** sending data ****************************/

	// once reading done send data via dataout in sync with the clk(clkout)
	// "sent" here indicates "addrout" reached 0xf and overflow occured
	// ie, sending done...
	// reading in rx should be done at posedge of clkout...
	always #2
		if(encoded & ~sent) clkout = ~clkout;

	always@ (negedge clkout)
		if(encoded)
		begin
			{sent,addrout} = addrout + 1;
		end

	assign dataout = mem[addrout];

	endmodule
