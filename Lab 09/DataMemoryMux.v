`timescale 1ns / 1ps


module Mux2(out,MemtoReg,in1, in0);
    input [64:0] in1, in0;
    input MemtoReg;
    output reg  [64:0] out;
    
always @(MemtoReg or in1 or in0) begin    
    if(MemtoReg) begin
        out <= in1; 
    end
    else begin
        out <= in0;
    end
end  
    
    
endmodule
