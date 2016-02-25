//top level file
module processor();

reg clk;

wire [31:0] instr; //in fetch stage
wire [31:0]IF_out; //fetch-decode stage reg

///////////////////////////
//outputs from control block
wire [3:0]rn, rm, rd;
wire [31:0] imm_ext;
wire [5:0]opcode;
wire rn_en, rm_en, s, i, m_en, rw_en, w_en, sh_en, sh;
wire [4:0]sh_imm;

///////////////////////////
//regfile in_out
wire write;
wire [3:0]wAddr;
wire [31:0]wData;
wire [108:0]de_out;
wire [31:0] Rn_v, Rm_v;

reg s_wb;
reg [3:0] wr_to_cpsr;
reg cpsr_rdEn;
wire [3:0] cpsrData;
	
///////////////////////////
//decode-exec inouts
wire [31:0]B, alu_result;
wire [31:0]B_v;

wire [3:0] cpsr;
wire Br;

wire brm_en, brw_en;
///////////////////////////
//ex-mem reg
wire [102:0]em_out;

///////////////////////////
//dout of dmemory
wire [31:0]d_out;

///////////////////////////
//mem-wb reg
wire [69:0]mw_out;

////////////////////////////

fetch Fetch_stage(clk, alu_result, Br, instr);
PipeRegI IF_ID(IF_out, instr, clk);

decoder Decstage(IF_out, rn, rm, imm_ext, opcode, rn_en, rm_en, s, i, m_en, rw_en, w_en, sh_en, sh, sh_imm, rd);
registerfile RegFile(clk, rm_en, rn_en, write, wAddr, wData, rm, Rm_v, rn, Rn_v, s_wb, wr_to_cpsr, cpsr_rdEn, cpsrData);
MUX_2to1 imm_mux(Rm_v, imm_ext, i, B_v);
PipeRegD ID_EX(de_out, {IF_out[23:0], Rn_v, B_v, s, opcode, m_en, rw_en, w_en, rd, sh_en, sh, sh_imm}, clk);

assign brm_en = (de_out[13]&(~Br));
assign brw_en = (de_out[11]&(~Br));
shifter sft(B, de_out[52:21], de_out[5], de_out[6], de_out[4:0]);
alu exec(de_out[19:14], de_out[84:53], B, de_out[20], de_out[108:85], alu_result, cpsr, Br);
PipeReg1 EX_MEM(em_out, {alu_result, B, de_out[84:53], brm_en, de_out[12], brw_en, de_out[10:7]}, clk);

data_memory dataMem(d_out, em_out[70:39], em_out[38:7], em_out[6], em_out[5]);
PipeReg MEM_WB(mw_out, {em_out[102:71], d_out, em_out[6], em_out[3:0], em_out[4]}, clk);

write_back Wb(wData, wAddr, write, mw_out[37:6], mw_out[69:38], mw_out[4:1], mw_out[0], mw_out[5]);


initial begin
#10 clk = 1;
#150 $finish;
end

always begin
#10 clk = ~clk;
end

endmodule
