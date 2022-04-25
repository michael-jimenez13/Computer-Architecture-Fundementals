`timescale 1ns / 1ps


module NextPCLogic( CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch,NextPC); 
       input [63:0] CurrentPC, SignExtImm64; 
       input Branch, ALUZero, Uncondbranch; 
       output reg [63:0] NextPC; 
       /* write your code here */ 
	   always @(CurrentPC or SignExtImm64 or  Branch or ALUZero or Uncondbranch)begin
			#1;
			if(ALUZero & Branch) begin //and gate expression
			#1;	                       //turns on mux and updates PC with this logic no matter what
				        NextPC <= #2 SignExtImm64 + CurrentPC;
			end 
			else if(Uncondbranch)begin //if ALUZero  and Branch output 0 then it is up to uncodBranch 
				#1;				//to update pc with this logic
								//expresses the OR gate
				        NextPC <= #2 SignExtImm64 + CurrentPC;
				end
			else begin //if all values fail to turn on mux
				#1;		//then MUX is off and updates pc with this logic below
				        NextPC <= #1 CurrentPC + 4; //adds by 4
			end
	end //for always
endmodule