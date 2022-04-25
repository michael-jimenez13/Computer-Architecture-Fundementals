`timescale 1ns / 1ps

module DataMemory(ReadData, Address, WriteData, MemoryRead, MemoryWrite, Clock); 
     input [63:0] Address, WriteData; 
     input MemoryRead, MemoryWrite, Clock; 
     output reg [63:0] ReadData; 
	 
	 reg [63:0] Memory [63:0]; //64 double words for every double word is 64 bits
	 	 integer i ;

	 
initial begin
	ReadData <=  0;
	 
	for(i=0; i<64; i=i+1)begin
	 Memory[i] =i;
	 end
 end
	
// Using @(address) will lead to unexpected behavior as memories are synchronous elements like registers
	always @(posedge Clock ) begin
		if (MemoryWrite) begin
			Memory[Address] <= #20  WriteData;
			end
		end
		always @(negedge Clock) begin
   		  if (MemoryRead) begin
			ReadData <= #20 Memory[Address];
			end
    end
	
endmodule