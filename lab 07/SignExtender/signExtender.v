`timescale 1ns / 1ps

//instructions
`define D 11'b111110000X0;
`define CB 11'b10110100XXX;
`define B 11'b000101XXXXX;
`define Rshift 11'b1101001101X;
`define Rimm 11'b1XX10XX00X;


module SignExtender(BusImm, Imm32, Ctrl); 
  output reg [63:0] BusImm; 
  input [31:0] Imm32; 
  input [10:0] Ctrl; 

    always @(Ctrl or Imm32) begin
        case(Ctrl) 
        `D:
            BusImm <= {{55{Imm32[20]}}, Imm32[20:12]} ;
        `CB:
            BusImm[63:0] <= {{43{Imm32[23]}}, Imm32[23:5], 2 'b0};
        `B: 
            BusImm[63:0] <= {{36{Imm32[25]}}, Imm32[25:0],2'b0};
        `Rshift: 
            BusImm[63:0] <= {58'b0, Imm32[15:10]};
        `Rimm: 
            BusImm[63:0] <= {52'b0, Imm32[21:10]};
        default:  BusImm <= 0;
       
     endcase
  end
endmodule
