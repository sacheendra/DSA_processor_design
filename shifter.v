module shifter(
			output [31:0] B,
			input [31:0] Rm,
			input shift,
			input shift_enable,
			input [4:0] shift_imm);


reg [31:0] temp;

always@(*)
begin
	if(shift_enable)
	begin
		if(shift)
		begin
			temp = Rm << shift_imm;
		end
		else
		begin
			temp = Rm >> shift_imm;
		end
	end
	else
	begin
		temp = Rm;
	end
end

assign B = temp;

endmodule