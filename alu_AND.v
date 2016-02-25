module alu_AND(A,B,Y);

input [31:0] A,B;
output wire [31:0] Y;

assign Y = A&B;


endmodule