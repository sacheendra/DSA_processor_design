module alu_compare(A,B,Y,cpsr);

input [31:0] A,B;
output wire [3:0] cpsr;
output wire [31:0] Y;

alu_SUB cmp_sub(A,B,Y,cpsr);

endmodule