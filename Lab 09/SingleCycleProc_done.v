`timescale 1ns / 1ps

module SingleCycleProc(CLK, Reset_L, startPC, currentPC, dMemOut);
   input CLK;
   input Reset_L;
   input [63:0] startPC;
   output [63:0] currentPC;
   output [63:0] dMemOut;
   
   //PC Logic
   wire [63:0]      nextPC;
   reg [63:0]      currentPC;
   
   //Instruction Decode
   wire [31:0]      currentInstruction;
   wire [10:0]      opcode;
   wire [4:0]      rm,rn,rd;
   wire [5:0]      shamt;

   // Decoding instruction fields
   assign {opcode, rm, shamt, rn, rd} = currentInstruction;
   
   //Register wires
   wire [63:0]      busA, busB, busW; //buses for inputs and
   //outputs of regfile
   wire [4:0]	rA;
   wire [4:0]      rB; // Used to attach output of
   // Reg2Loc mux to B input register
   // index input
   
   //Control Logic Wires
   wire      Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch;
   wire [1:0]      ALUOp;
   wire [3:0]      ALUCtrl;

   
   //ALU Wires
   wire [63:0]      signExtImm64, ALUImmRegChoice;
   wire [63:0]      ALUResult;
   wire      ALUZero;
   
   //Data Memory Wires
   wire [63:0]      dMemOut;

   //Instruction Memory
   InstructionMemory instrMem(.Data(currentInstruction), .Address(currentPC));    
   



   //PC Logic
   NextPClogic next(.NextPC(nextPC), .CurrentPC(currentPC), .SignExtImm64(signExtImm64), .Branch(Branch), .ALUZero(ALUZero), .Uncondbranch(Uncondbranch));
   
always @ (negedge CLK, negedge Reset_L)
   begin
  	if(~Reset_L)
    currentPC = startPC;
  	else
    currentPC = nextPC;
   end
   
   //Control
   SingleCycleCONTROL control(.Reg2Loc(Reg2Loc), .ALUSrc(ALUSrc), .MemToReg(MemToReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .Uncondbranch(Uncondbranch), .ALUOp(ALUOp), .Opcode(opcode));


   
   //Register file
   /*create the Reg2Loc mux*/

   assign #2  rB = Reg2Loc ? rd : rm;  // rd if 1 , rm if 0

   RegisterFile registers(.BusA(busA), .BusB(busB), .BusW(busW), .RA(rn), .RB(rB), .RW(rd), .RegWr(RegWrite), .Clk(CLK));
   
   //Sign Extender
   /*instantiate your sign extender*/
    
  SignExtender SignExt(.BusImm(signExtImm64), .Imm32(currentInstruction));
   
   //ALU
   ALUControl ALUCont(.ALUctrl(ALUCtrl), .ALUop(ALUop), .Opcode(opcode));


   assign #2 ALUImmRegChoice = ALUSrc ? signExtImm64 : busB;
   ALU	mainALU(.result(ALUResult), .Zero(ALUZero), .BusA(busA), .BusB(ALUImmRegChoice), .ALUCtrl(ALUCtrl));
   
   //Data Memory
   DataMemory data(.ReadData(dMemOut), .Address(ALUResult), .WriteData(busB), .MemoryRead(MemRead), .MemoryWrite(MemWrite), .Clock(CLK));

   /*create MemToReg mux */

	assign #2 busW = MemToReg ? dMemOut : ALUResult;
   
endmodule
