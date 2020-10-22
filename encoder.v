	module encoder(
		input datain,clk,
		output dataout,
		output reg clkout);
	reg mem[15:0];
	reg[3:0] addr;
	reg encoded;

	wire w1,w2,w3,w4,w5;
	
	assign dataout = mem[addr];

	initial
	begin
		addr<=4'h0; mem[0]<=0;mem[1]<=0;mem[2]<=0;mem[4]<=0;mem[8]<=0; encoded<=0; clkout<=0;
	/*	if(encoded)	//send data...
		begin
			always #2 clkout = ~clkout;
			addr = 4'h0;
			#4 addr = addr + 1;
		end
*/	end

	always@ (posedge clk)
	begin
		mem[addr] = datain;
		{encoded,addr} = addr + 1;
	end

	assign w1 = datain ^ mem[0];
	assign w2 = (datain & addr[0]) ^ mem[1];
	assign w3 = (datain & addr[1]) ^ mem[2];
	assign w4 = (datain & addr[2]) ^ mem[4];
	assign w5 = (datain & addr[3]) ^ mem[8];

	always@ (posedge clk)
	begin
		mem[0] <= w1;
		mem[1] <= w2;
		mem[2] <= w3;
		mem[4] <= w4;
		mem[8] <= w5;
	end

	endmodule
