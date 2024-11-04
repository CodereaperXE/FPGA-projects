module top(
	input clk,
	output led_red
	);

	localparam N =24;

	reg [N-1:0] counter;

	always @(posedge clk) begin
		counter <= counter + 1;
	end

	assign led_red = counter[N-1];


endmodule



