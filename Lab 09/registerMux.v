`timescale 1ns / 1ps


module Mux1(ReadRegister2,reg2loc,in0,in1);

    input reg2loc;
    input [4:0] in0, in1;
    output reg [4:0] ReadRegister2;
 
    always @(reg2loc or in0 or in1) begin
        if(reg2loc) begin
            ReadRegister2 <= in1;
        end
        else begin
            ReadRegister2 <= in0;
        end
end    
endmodule
