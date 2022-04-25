`timescale 1ns / 1ps


module NextPClogic( NextPC,CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
       input [63:0] CurrentPC, SignExtImm64; 
       input Branch, ALUZero, Uncondbranch; 
       output reg [63:0] NextPC; 
       /* write your code here */ 
       wire test;
       wire [63:0] Twoshift;
       assign test = ALUZero & Branch; 
       assign Twoshift = SignExtImm64 *4;
	   
	   always @(CurrentPC or SignExtImm64 or  Branch or ALUZero or Uncondbranch)begin
			
			if(test) begin //and gate expression
				                       //turns on mux and updates PC with this logic no matter what
				        NextPC <= #3 Twoshift + CurrentPC;
			end 
			else if(Uncondbranch)begin //if ALUZero  and Branch output 0 then it is up to uncodBranch 
							//to update pc with this logic
								//expresses the OR gate
				        NextPC <= #3 Twoshift + CurrentPC;
				end
			else begin //if all values fail to turn on mux
						//then MUX is off and updates pc with this logic below
				        NextPC <= #2 CurrentPC + 4; //adds by 4
			end
	end //for always
endmodule