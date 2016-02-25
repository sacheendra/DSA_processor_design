module MUX_2to1(inp1,inp2,sel,out);

input [31:0]inp1;
input [31:0]inp2;
input sel;
output wire [31:0]out;

assign out = (sel == 0)?(inp1):(inp2);

endmodule