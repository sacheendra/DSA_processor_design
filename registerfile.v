module registerfile
  (input clk,
   input rmEn,
   input rnEn, 
   input write,
   input [3:0] wrAddr,
   input [31:0] wrData,
   input [3:0] rdAddrm,
   output reg [31:0] rdDatam,
   input [3:0] rdAddrn,
   output reg [31:0] rdDatan,
	input s,
	input [3:0] wr_to_cpsr,
	input cpsr_rdEn,
	output reg [3:0] cpsrData);

   reg [31:0] 	 mem [0:15];
	reg [3:0]    mem1 [0:1];
	
	initial begin
	mem[0] = 0;
	mem[1] = 1;
	mem[2] = 2;
	mem[3] = 3;
	mem[4] = 4;
	mem[5] = 5;
	end
	
   always @(negedge clk)
   begin
	if(rmEn)
	begin
   		rdDatam <= mem[rdAddrm];
	end
	if(rnEn)
	begin
   		rdDatan <= mem[rdAddrn];
	end
	if(cpsr_rdEn)
	begin
		cpsrData <= mem1[0];
	end
	end
	
   always @(posedge clk)
   begin
      if (write) 
		begin
				mem[wrAddr] <= wrData;
		end
		if(s)
		begin
			mem1[0] <= wr_to_cpsr;
		end
   end
endmodule
