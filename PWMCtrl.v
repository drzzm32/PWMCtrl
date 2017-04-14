module PWMCtrl(
	clk,
	up, down,
	out, state
);
	parameter CNT = 32'd10;
	parameter KEY = 32'd5000000;
	
	input clk, up, down;
	output out;
	output[7:0] state;
	reg[31:0] cnt, key;
	reg[7:0] tim, value;
	reg out;
	
	initial begin
		cnt <= 32'b0;
		key <= 32'b0;
		tim <= 8'b0;
		value <= 8'b1;
	end
	
	always @(posedge clk) begin
		if (cnt < CNT) cnt <= cnt + 32'b1;
		else begin
			cnt <= 32'b0;
			out <= (tim < value);
			if (tim != 8'hff) tim <= tim + 8'b1;
			else tim <= 8'b0;
		end
	end
	
	always @(posedge clk) begin
		if (key < KEY) key <= key + 32'b1;
		else begin
			key <= 32'b0;
			if (!up) value <= ((value << 1'b1) | 8'b1);
			else if (!down) value <= ((value >> 1'b1) | 8'b1);
		end
	end
	
	assign state = ~value;

endmodule
