module control(instr, rn, rm, rd, imm, memEn, regW, regRn, regRm, ls, I, S, opcode, shift, shift_imm, shiftEn);

input [31:0] instr;
output reg [3:0] rn, rm, rd;
output reg memEn, regW, regRn, regRm, I, S, ls, shift, shiftEn;
output reg [4:0] shift_imm;
output reg [5:0] opcode;
output reg [15:0] imm;
reg temp;

//sign_extend sign(instr[15:0], imm);

always@(instr)
begin
	I = instr[31];
	S = instr[30];
	memEn = instr[29] & instr[28];
	ls = instr[27];
	temp = instr[29] | instr[28];
	if((memEn == 2'b11) && (instr[27] == 0))
		regW = 0;
	else 
		regW = 1;
	regRn = 1;
	regRm = ~I;
	rn = instr[23:20];
	rm = instr[3:0];
	if(temp == 1)
		rd = instr[23:20];
	else 
		rd = instr[19:16];
	
	opcode = instr[29:24];
	shiftEn = ~I;
	shift = instr[15];
	shift_imm = instr[14:10];
	imm = instr;
end

endmodule