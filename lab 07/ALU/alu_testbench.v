`timescale 1ns / 1ps

`define STRLEN 32
module ALUTest_v;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
         //add
         {BusA, BusB, ALUCtrl} = {64'h43, 64'h1231, 4'h2}; #40; passTest({Zero, BusW}, 65'h1274, "ADD 0x43,0x1231", passed);
         {BusA, BusB, ALUCtrl} = {64'h20, 64'h4500, 4'h2}; #40; passTest({Zero, BusW}, 65'h4520, "ADD 0x20,0x4500", passed);
         {BusA, BusB, ALUCtrl} = {64'h1234, 64'h900, 4'h2}; #40; passTest({Zero, BusW}, 65'h1B34, "ADD 0x1234,0x900", passed);
        //sub
         {BusA, BusB, ALUCtrl} = {64'h120, 64'h87, 4'h6}; #40; passTest({Zero, BusW}, 65'h99, "SUB 0x120,0x87", passed);
         {BusA, BusB, ALUCtrl} = {64'h4678, 64'h1234, 4'h6}; #40; passTest({Zero, BusW}, 65'h3444, "SUB 0x4678,0x1234", passed);
         {BusA, BusB, ALUCtrl} = {64'h800, 64'h1232, 4'h6}; #40; passTest({Zero, BusW}, 65'hFFFFFFFFFFFFF5CE, "SUB 0x800,0x1232", passed);
        //and
         {BusA, BusB, ALUCtrl} = {64'h4333, 64'h780, 4'h0}; #40; passTest({Zero, BusW}, 65'h300, "AND 0x4333,0x780", passed);
         {BusA, BusB, ALUCtrl} = {64'h777, 64'h445, 4'h0}; #40; passTest({Zero, BusW}, 65'h445, "AND 0x777,0x445", passed);
         {BusA, BusB, ALUCtrl} = {64'h2345, 64'h69FB, 4'h0}; #40; passTest({Zero, BusW}, 65'h2141, "AND 0x2345,0x69FB", passed);
        //or
        {BusA, BusB, ALUCtrl} = {64'hABCD, 64'hF0F0, 4'h1}; #40; passTest({Zero, BusW}, 65'hFBFD, "OR 0xABCD,0xF0F0", passed);
        {BusA, BusB, ALUCtrl} = {64'h689, 64'hA13, 4'h1}; #40; passTest({Zero, BusW}, 65'hE9B, "OR 0x689,0xA13", passed);
        {BusA, BusB, ALUCtrl} = {64'h1234, 64'h1234, 4'h1}; #40; passTest({Zero, BusW}, 65'h1234, "OR 0x1234,0x1234", passed);
        //cbz
        {BusA, BusB, ALUCtrl} = {64'h400, 64'h231, 4'h7}; #40; passTest({Zero, BusW}, 65'h231, "CBZ 0x400,0x231", passed);
        {BusA, BusB, ALUCtrl} = {64'h0, 64'h123, 4'h7}; #40; passTest({Zero, BusW}, 65'h123, "CBZ 0x0,0x123", passed);
        {BusA, BusB, ALUCtrl} = {64'h3424, 64'h2312, 4'h7}; #40; passTest({Zero, BusW}, 65'h2312, "CBZ 0x3424,0x2312", passed);
        //LSL
       {BusA, BusB, ALUCtrl} = {64'h123, 64'h4, 4'h3}; #40; passTest({Zero, BusW}, 65'h1230, "LSL 0x123,0x4", passed);
       {BusA, BusB, ALUCtrl} = {64'hABFC, 64'hA, 4'h3}; #40; passTest({Zero, BusW}, 65'h2AFF000, "LSL 0xABFC,0xA", passed);
       {BusA, BusB, ALUCtrl} = {64'h6, 64'h3, 4'h3}; #40; passTest({Zero, BusW}, 65'h30, "LSL 0x6,0x3", passed);
        //LSR
       {BusA, BusB, ALUCtrl} = {64'hFAFA, 64'h4, 4'h4}; #40; passTest({Zero, BusW}, 65'hFAF, "LSR 0xFAFA,0x4", passed);
       {BusA, BusB, ALUCtrl} = {64'h1345, 64'hA, 4'h4}; #40; passTest({Zero, BusW}, 65'h4, "LSR 0x1345,0xA", passed);
       {BusA, BusB, ALUCtrl} = {64'hF35C, 64'hE, 4'h4}; #40; passTest({Zero, BusW}, 65'h3, "LSR 0xF35C,0xE", passed);


		allPassed(passed, 22);
	end
      
endmodule


