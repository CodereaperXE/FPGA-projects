

module uart_baud_gen(
					input clk,
					input [23:0] divisor,
					output reg baud_clk
					);
	reg [23:0] counter;

	always @(posedge clk) begin
		if(counter == divisor) begin
			baud_clk <= 1'b1;
			counter <= 24'd0;
		end else begin
			baud_clk <= 1'b0;
			counter <= counter + 1;
		end
	end
endmodule


module transmitter_uart(
					input clk,
					input [23:0] divisor,
					input [7:0] data,
					output reg out
					);
	reg baud_clk;
	uart_baud_gen uart_baud_gen_instance(.clk(clk),.divisor(divisor),.baud_clk(baud_clk));

	reg [23:0] counter;

	always @(posedge baud_clk) begin
		if(counter == 24'd0) begin
			out <= 1'b0; //start bit
		end else if(counter > 24'd0 && counter < 24'd9) begin
			out <= data[7-(counter-1)];
		end else if(counter == 24'd9) begin
			out <= 1'b1;
		end

		if(counter==24'd9) begin
			out <= 1'b1;
			counter <= 24'd0;
		end else begin
			counter <= counter + 1;
		end
	end
endmodule

module main(input CLK,input ICE_SW2, output ICE_28);
	reg [7:0] data;
	reg [23:0] divisor;
	always @(negedge ICE_SW2) begin
		data <= 8'hff;
		divisor <= 24'd1250;
	end

	transmitter_uart uart_instance(.clk(CLK),.out(ICE_28),.data(data),.divisor(divisor));
endmodule

