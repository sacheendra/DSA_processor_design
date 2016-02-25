module pred_1(output reg [31:0] pc_pred,
	output pred,
	input [31:0] instr,
	//input pred_fb,
	input [31:0] pc_now
	);

reg [31:0] temp;

always@(instr) begin
temp = {8'b0,instr[23:0]}
    if(temp < pc_now) begin
    pc_pred <= temp;
    end
    else begin
    pc_pred <= pc_now + 4;
    end

endmodule
