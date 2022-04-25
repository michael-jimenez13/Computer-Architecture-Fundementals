`timescale 1ns / 1ps


//alu control
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SUB 4'b0110
`define PassB 4'b0111

//opcodes for opfield
`define ADD1 11'b10001011000
`define SUB1 11'b11001011000
`define AND1 11'b10001010000
`define ORR1 11'b10101010000
//original opcodes
//`define LDUR 11'b11111000010
//`define STUR 11'b11111000000
//`define CBZ 11'b10110100XXX

`define SturLdurCbz 11'bXXXXXXXXXXX

 module ALUControl( ALUop, Opcode, ALUctrl); 

     input [1:0] ALUop; 
     input [10:0] Opcode; 
     output reg [3:0] ALUctrl; 

	 //trigger when inputs are in
	 always @(Opcode or ALUop) begin
		
		case(ALUop)//for AlUop 2 binary bits
		2'b00://LDUR and STUR
		
			case(Opcode) //when calling Instruction
				`SturLdurCbz:
					ALUctrl <= #2 `ADD;//ADD for LDUR
				default: ALUctrl <= #2 0;
			endcase
				
		2'b01://CBZ
		
			case(Opcode) //when calling Instruction
                `SturLdurCbz:
                     ALUctrl <= #2 `PassB;//ADD for LDUR
                 default: ALUctrl <= #2 0;
               endcase
                    
		2'b10://R-Type Instructions
		  
		  case(Opcode)
				`ADD1:
					ALUctrl <=  #2 `ADD; //alu function add
				`SUB1:
					ALUctrl <= #2 `SUB;//alu function subtract
				`AND1:
					ALUctrl <= #2 `AND;//alu function AND
				`ORR1:
					ALUctrl <= `OR;//alu fucntin OR
				default: ALUctrl <= #2 0;
		  endcase
		
		default: ALUctrl <= #2 0;
	 endcase
	end //always ends
	 
endmodule