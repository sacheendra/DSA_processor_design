module data_memory(
                output reg [31:0] data_out,
                input [31:0] address,
                input [31:0] data_in, 
                input rw_enable,
                input mem_enable);
                //input clk

    reg [31:0] memory [0:1023];

    always @(*) 
    begin
        if(mem_enable)
        begin
           if (~rw_enable) // 0 for write, 1 for load
            begin
               memory[address] <= data_in;
            end
            data_out <= memory[address];
        end
    end
	
initial begin
memory[0] = 0;
memory[1] = 1;
memory[2] = 2;
memory[3] = 3;
memory[4] = 4;
end
endmodule