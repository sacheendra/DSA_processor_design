module alu(
		input [5:0] opcode,
		input [31:0] A,
		input [31:0] B,
		input s,
		input [23:0] pc_br,
		output reg [31:0] result,
		output reg [3:0] cpsr,
		output reg Br
		);

reg[3:0] mem;

wire [31:0] radd, rsub, rand, ror, rnot, rxor, rcmp, rmov;
wire [3:0] cadd, csub, ccmp;
alu_ADD adder(A, B, radd, cadd);
alu_SUB sub(A, B, rsub, csub);
alu_AND andgate(A, B, rand);
alu_OR orgate(A, B, ror);
alu_NOT notgate(A, B, rnot);
alu_EXOR exorgate(A, B, rxor);
alu_compare cmp(A, B, rcmp, ccmp);
alu_mov mov(A, B, rmov);

always@(*)
begin
 case(opcode)
   6'b000110 :  begin
                result = radd;
                cpsr = cadd; if(s) mem = cpsr;
   		end
   6'b001001 :  begin
                result = rsub;
                cpsr = csub; if(s) mem = cpsr;
                end
   6'b001011 : 
                result = rand;
                
   6'b001010 : 
                result = ror;
                
   6'b001100 :  
                result = rnot;
                
   6'b001110 : 
                result = rxor;
                 
   6'b011101 :  begin
                result = rcmp;
	        cpsr = ccmp; if(s) mem = cpsr;
		end
   6'b011100:	
   		result = rmov;
//BEQ//
   6'b100100:   begin
		Br = mem[2];
		result = {8'b00000000 , pc_br};
		#40 Br = 0;
		end	

endcase
end

endmodule