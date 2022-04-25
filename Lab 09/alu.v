`timescale 1ns / 1ps

`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define LSL 4'b0011
`define LSR 4'b0100
`define SUB 4'b0110
`define PassB 4'b0111


module ALU(result,Zero,BusA, BusB, ALUCtrl );
    
    parameter n = 64;

    output  [n-1:0] result;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
    
    reg     [n-1:0] result;
      assign Zero = (result == 0);

    always @(ALUCtrl or BusA or BusB) begin
        case(ALUCtrl)
            `AND: 
                result <= #20 BusA & BusB;
			`OR:  
				result  <= #20 BusA | BusB; 
			`ADD: 
				result  <= #20 BusA + BusB;
			`LSL: 
				result  <= #20 BusA << BusB;
			`LSR: 
			    result <=  #20 BusA >> BusB;
			`SUB: 
				result  <= #20 BusA - BusB;
			`PassB: 
				result  <= #20 BusB;
		default: result <= #20 0;
        endcase
    end
endmodule
