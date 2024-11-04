

module decoder(input wire [1:0] in,output reg [3:0] y);
	always @* begin
		case(in)
			2'b00: y = 4'b0001;
			2'b01: y = 4'b0010;
			2'b10: y = 4'b0100;
			2'b11: y = 4'b1000;
			default: y = 4'b0000;
		endcase
	end
endmodule

module main(output red_led,output green_led,output blue_led,input clk);
	reg [23:0] counter;
	always @(posedge clk) begin
		counter <= counter + 1;
	end;

	reg [3:0] decoded;
	decoder my_decoder(.in(counter[23:22]),.y(decoded));

	always @* begin
		{red_led,green_led,blue_led} = ~decoded[3:1];
	end
endmodule

