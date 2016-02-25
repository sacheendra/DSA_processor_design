module PipeReg1(q, d, clk);

parameter n = 103;

output reg [n-1:0]q;
input [n-1:0]d;
input clk;

always@(posedge clk)
begin
	q <= d;
end
endmodule
