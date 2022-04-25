`timescale 1ns / 1ps

//instructions
//`define D 32'b111110000X0XXXXXXXXXXXXXXXXXXXXX
//`define CB 32'b10110100XXXXXXXXXXXXXXXXXXXXXXXX
//`define B 32'b000101XXXXXXXXXXXXXXXXXXXXXXXXXX
//`define Rshift 32'b1101001101XXXXXXXXXXXXXXXXXXXXXX
//`define Rimm 32'b1XX10XX00XXXXXXXXXXXXXXXXXXXXXXX


module SignExtender(BusImm, Imm32); 
  output reg [63:0] BusImm; 
  input [31:0] Imm32; 
 wire opcode;
  assign opcode = Imm32[31:21];
    always @(Imm32) begin  
      case(opcode) 
        11'b111110000X0: begin //Dinstructions
            BusImm[63:0] <= #2 {{55{Imm32[20]}}, Imm32[20:12]} ;
        end
        11'b10110100XXX: begin //CB instructions
            BusImm[63:0] <= #2 {{45{Imm32[23]}}, Imm32[23:5]};
            end
        11'b000101XXXXX: begin //B instructions
            BusImm[63:0] <= #2 {{38{Imm32[25]}}, Imm32[25:0]};
            end
        11'b1101001101X: begin //R shift instructions
            BusImm[63:0] <= #2 {58'b0, Imm32[15:10]};
            end
        11'b1XX100XX00X: begin //R Immidiate instructions
            BusImm[63:0] <= #2 {52'b0, Imm32[21:10]};
            end
        default: begin 
            BusImm[63:0] <= #2  64'h0;
         end
     endcase 
  end
endmodule
