	/************************** DECODER MODULE *********************

	* Receives data from the encoder module. Computes parity of the 
	* received data...

	***************************************************************/

	module decoder(
		input datain,clk,
		output data,res);
	reg dataout[15:0];
	reg[3:0] addr;
	reg check;
	wire w1;

	initial
	begin
		// initialise the variables to known state...
		addr <= 4'h0;
		check <= 0;
	end

	always@ (posedge clk)
	begin
		// assign received data at clk edge
		dataout[addr] = datain;
		// increment the address
		addr = addr + 1;
	end

	// calculate parity of received data and assign to w1
	xor g1(w1,datain,check);

	always@ (posedge clk)
	begin
		// assign calculated parity to a register(check)
		check = w1;
	end

	// result: if calculated parity is equal to the
	// parity bit received, set to 1 else 0...
	assign res = (check == dataout[4'hf]) ? 1 : 0;

	endmodule
