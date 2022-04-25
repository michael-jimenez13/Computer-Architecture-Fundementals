`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
  output [63:0] BusA, BusB;
  input [63:0] BusW;
  input [4:0] RA, RB, RW;
  input RegWr;
  input Clk;

  reg [63:0] registers [31:0];

  assign #2 BusA = registers[RA];
  assign #2 BusB = registers[RB];

  always @ (negedge Clk) 
  begin
    if(RegWr)begin
    if( RW != 5'd31)begin
              registers[RW] <= #3 BusW;
    end
    else begin
                  registers[0] <= #3 0;
    end
  end
  end
endmodule