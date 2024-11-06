

module gpio(
			input clk,
			output pin
			);

	reg [23:0] counter;

	always @(posedge clk) begin
		counter <= counter + 1;
	end

	
	assign pin = counter[23];
	
endmodule


module main(
			input CLK,
			output ICE_28
			);

	gpio test(.clk(CLK),.pin(ICE_28));

endmodule