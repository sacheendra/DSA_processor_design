module alu_ADD(A,B,Y,cpsr);

input [31:0] A,B;
output wire [3:0] cpsr;
output wire [31:0] Y;



assign {cpsr[3], Y} = A + B;
assign cpsr[2] = ~|Y;
assign cpsr[1] = Y[31];
assign cpsr[0] = A[31]^B[31]^Y[31]^cpsr[3];

endmodule