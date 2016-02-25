module decoder(
		input [31:0]instr,
		output [3:0]rn,
		output [3:0]rm,
		output [31:0]imm_ext,
		output [5:0]opcode,
		output rn_en,
		output rm_en,
		output s, 
		output i,
		output m_en,
		output rw_en, 
		output w_en,
		output sh_en, 
		output sh,
		output [4:0]sh_imm,
		output [3:0]rd
		);

wire [15:0]imm;

control ctrl(instr, rn, rm, rd, imm, m_en, w_en, rn_en, rm_en, rw_en, i, s, opcode, sh, sh_imm, sh_en);
sign_extend s_ext(imm, imm_ext);

endmodule