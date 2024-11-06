module adder(
			input wire [3:0] a,
			input wire [3:0] b,
			input wire cin,
			output reg [3:0] y,
			output reg cout
);
	reg [4:0] temp_result;
	always @* begin

		temp_result = {1'b0,a} + {1'b0,b} + cin;
		y = temp_result[3:0];
		cout = temp_result[4];
	end
endmodule

module main(
			output reg red_led,
			input clk
);
	reg a = 4'b0001;
	reg b = 4'b0001;
	reg cin = 1'b0;

	wire [3:0] y;
	wire cout;

	adder add(.a(a),.b(b),.cin(cin),.y(y),.cout(cout));

	wire [3:0] result;
	assign result = y;

	always @(posedge clk) begin
		if(result == 4'b0010) begin
			red_led = 1'b0;
		end else begin
			red_led = 1'b1;
		end
	end
endmodule