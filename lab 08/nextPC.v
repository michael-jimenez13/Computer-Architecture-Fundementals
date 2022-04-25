`timescale 1ns / 1ps

`define CB 11'b10110100XXX;
`define B 11'b000101XXXXX;



module ALU(nextPC, currPC, Ctrl, Zero);
    
    parameter n = 64;

    output  [n-1:0] nextPC;
    input   [n-1:0] currPC;
    input   [10:0] Ctrl;
    
    reg     [n-1:0] nextPC;

    always @(Ctrl or currPC) begin
        case(Ctrl)
            `CB: 
                nextPC <=  currPC;
			`B:  
				nextPC  <=  currPC; 
			
		default: nextPC <= currPC +1;
        endcase
    end
endmodule
