	`timescale 10ns/1ns

	module encoder(
		input datain,clk,
		output reg dataout,
		output reg clkout);
	reg mem[15:0];
	reg[3:0] addr,addrout;
	reg parity,encoded,sent;

	wire w1,w2,w3,w4,w5;
	
	initial
	begin
		addr<=4'h0;sent<=0;parity<=0;mem[0]<=0;mem[1]<=0;mem[2]<=0;mem[4]<=0;mem[8]<=0; encoded<=0; clkout<=0;addrout<=4'h0;
	end

	always@ (posedge clk)
	begin
		mem[addr] = datain;
		{encoded,addr} = addr + 1;
	end

	assign w1 = datain ^ parity;
	assign w2 = (datain & addr[0]) ^ mem[1];
	assign w3 = (datain & addr[1]) ^ mem[2];
	assign w4 = (datain & addr[2]) ^ mem[4];
	assign w5 = (datain & addr[3]) ^ mem[8];

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

	always #2
		if(encoded) clkout = ~clkout;

	always@ (posedge clkout)
	begin
//		dataout = mem[addrout];//	mem[addr] = datain;
		addrout = addrout + 1;
//		if (sent) $finish;
	end
	always@ (negedge clkout)
		dataout = mem[addrout];
	endmodule
