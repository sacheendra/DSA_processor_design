module write_back(		
				output [31:0] result,
				output reg [3:0] Rd,
				output reg write,
				//output [31:0] cpsr,
				//output s,
				input [31:0] data_in,
				input [31:0] alu_in,
				input [3:0] Rd_in,
				input w_en,
				//input [31:0] cpsr_in,
				//input s_in,
				input mem_enable);

MUX_2to1 wb(alu_in, data_in, mem_enable, result);
//assign cpsr = cpsr_in;
//assign s = s_in;
always@(*)
begin
Rd = Rd_in;
write = w_en;
end
endmodule