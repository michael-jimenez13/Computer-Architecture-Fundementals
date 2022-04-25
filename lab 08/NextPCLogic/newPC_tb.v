`timescale 1ns / 1ps

`define STRLEN 32

module nextPC();
    //to prove all cases work
   task passTest;
		input [3:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;

		if(actualOut == expectedOut) begin $display ("%s passed", testType); end
		else $display ("%s failed: %d should be %d", testType,  actualOut, expectedOut);
	endtask

	// Inputs
	   reg [63:0] CurrentPC, SignExtImm64; 
       reg Branch, ALUZero, Uncondbranch; 

	// Outputs
       wire [63:0] NextPC; 

	// Instantiate the Unit Under Test (UUT)
	NextPCLogic test (
			.CurrentPC(CurrentPC),
		    .SignExtImm64(SignExtImm64), 
			.Branch(Branch), .ALUZero(ALUZero),
			.Uncondbranch(Uncondbranch),
			.NextPC(NextPC)
	);

	initial begin
		// Initialize Inputs
		#0
		CurrentPC = 0;
		SignExtImm64 = 0;
		Branch = 0;
		ALUZero = 0;
		Uncondbranch = 0;
		
		// Add stimulus here
		$display("Init Memory with some useful data");
		
        //case1: in this test all control values are 0
		//output should be NextPC= CurrentPC+4;
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hFAFAF0F0ABCD0201, 64'hFFFFFFFF20003002, 1'b0, 1'b0,1'b0};
        #6
        passTest(NextPC, 64'hFAFAF0F0ABCD0205, "NextPC is correct for case  1");
	   
	   //case 2a: in this test  unconditional branch  is 1 and the rest are 0
       //output should be NextPC= CurrentPC+SignExtImm64;
         #100
         {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1234567800100200, 64'h1234567101010000, 1'b0, 1'b0,1'b1};
         #6
         passTest(NextPC, 64'h2468ACD901110200, "NextPC is correct for case  4");
		
		
		//case 3:in this test  ALUZero is 1 and the rest are 0
		//output should be NextPC= CurrentPC+4;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1234567800000007, 64'h876543210000000, 1'b0, 1'b1,1'b0};
        #6//B in hexcode so it  is 11
        passTest(NextPC, 64'h123456780000000B, "NextPC is correct for case  3");

		
		//case 4a: in this test unconditional branch is 1 and ALUZero is 1 and the rest are 0
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1111222200000003, 64'h1111222200000004, 1'b0, 1'b1,1'b1};
        #6
        passTest(NextPC, 64'h2222333300000007, "NextPC is correct for case  5");
		
		//case 5a: in this test branch is 1 and the rest are 0
        //output should be NextPC= CurrentPC+4;
        #100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hBABEFFFF00000002, 64'hBAB0BABE00000030, 1'b1, 1'b0,1'b0};
        #6
         passTest(NextPC, 64'hBABEFFFF00000006, "NextPC is correct for case  2");
                
		//case 6: in this test unconditional branch is 1 and branch is 1 and the rest are 0
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h333344440A000008, 64'h3333444400000001, 1'b1, 1'b0,1'b1};
        #6
        passTest(NextPC, 64'h777788880A000009, "NextPC is correct for case  6");
		
		//case 7: in this test control values are all 1
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hA531111100001231, 64'h00000000FFFF0003, 1'b1, 1'b1,1'b0};
        #6
        passTest(NextPC, 64'hA531111100001234, "NextPC is correct for case  7");
        
        //case 8: 
        //output should be NextPC= CurrentPC+SignExtImm64;
         #100
         {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hABCD123400011111, 64'h0000123400010101, 1'b1, 1'b1,1'b1};
         #6
         passTest(NextPC, 64'hABCD246800021212, "NextPC is correct for case  8");
                
	end
      
endmodule

`timescale 1ns / 1ps

`define STRLEN 32

module nextPC();
    //to prove all cases work
   task passTest;
		input [3:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;

		if(actualOut == expectedOut) begin $display ("%s passed", testType); end
		else $display ("%s failed: %d should be %d", testType,  actualOut, expectedOut);
	endtask

	// Inputs
	   reg [63:0] CurrentPC, SignExtImm64; 
       reg Branch, ALUZero, Uncondbranch; 

	// Outputs
       wire [63:0] NextPC; 

	// Instantiate the Unit Under Test (UUT)
	NextPCLogic test (
			.CurrentPC(CurrentPC),
		    .SignExtImm64(SignExtImm64), 
			.Branch(Branch), .ALUZero(ALUZero),
			.Uncondbranch(Uncondbranch),
			.NextPC(NextPC)
	);

	initial begin
		// Initialize Inputs
		#0
		CurrentPC = 0;
		SignExtImm64 = 0;
		Branch = 0;
		ALUZero = 0;
		Uncondbranch = 0;
		
		// Add stimulus here
		$display("Init Memory with some useful data");
		
        //case1: in this test all control values are 0
		//output should be NextPC= CurrentPC+4;
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hFAFAF0F0ABCD0201, 64'hFFFFFFFF20003002, 1'b0, 1'b0,1'b0};
        #6
        passTest(NextPC, 64'hFAFAF0F0ABCD0205, "NextPC is correct for case  1");
	   
	   //case 2a: in this test  unconditional branch  is 1 and the rest are 0
       //output should be NextPC= CurrentPC+SignExtImm64;
         #100
         {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1234567800100200, 64'h1234567101010000, 1'b0, 1'b0,1'b1};
         #6
         passTest(NextPC, 64'h2468ACD901110200, "NextPC is correct for case  4");
		
		
		//case 3:in this test  ALUZero is 1 and the rest are 0
		//output should be NextPC= CurrentPC+4;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1234567800000007, 64'h876543210000000, 1'b0, 1'b1,1'b0};
        #6//B in hexcode so it  is 11
        passTest(NextPC, 64'h123456780000000B, "NextPC is correct for case  3");

		
		//case 4a: in this test unconditional branch is 1 and ALUZero is 1 and the rest are 0
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1111222200000003, 64'h1111222200000004, 1'b0, 1'b1,1'b1};
        #6
        passTest(NextPC, 64'h2222333300000007, "NextPC is correct for case  5");
		
		//case 5a: in this test branch is 1 and the rest are 0
        //output should be NextPC= CurrentPC+4;
        #100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hBABEFFFF00000002, 64'hBAB0BABE00000030, 1'b1, 1'b0,1'b0};
        #6
         passTest(NextPC, 64'hBABEFFFF00000006, "NextPC is correct for case  2");
                
		//case 6: in this test unconditional branch is 1 and branch is 1 and the rest are 0
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h333344440A000008, 64'h3333444400000001, 1'b1, 1'b0,1'b1};
        #6
        passTest(NextPC, 64'h777788880A000009, "NextPC is correct for case  6");
		
		//case 7: in this test control values are all 1
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hA531111100001231, 64'h00000000FFFF0003, 1'b1, 1'b1,1'b0};
        #6
        passTest(NextPC, 64'hA531111100001234, "NextPC is correct for case  7");
        
        //case 8: 
        //output should be NextPC= CurrentPC+SignExtImm64;
         #100
         {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hABCD123400011111, 64'h0000123400010101, 1'b1, 1'b1,1'b1};
         #6
         passTest(NextPC, 64'hABCD246800021212, "NextPC is correct for case  8");
                
	end
      
endmodule

`timescale 1ns / 1ps

`define STRLEN 32

module nextPC();
    //to prove all cases work
   task passTest;
		input [3:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;

		if(actualOut == expectedOut) begin $display ("%s passed", testType); end
		else $display ("%s failed: %d should be %d", testType,  actualOut, expectedOut);
	endtask

	// Inputs
	   reg [63:0] CurrentPC, SignExtImm64; 
       reg Branch, ALUZero, Uncondbranch; 

	// Outputs
       wire [63:0] NextPC; 

	// Instantiate the Unit Under Test (UUT)
	NextPCLogic test (
			.CurrentPC(CurrentPC),
		    .SignExtImm64(SignExtImm64), 
			.Branch(Branch), .ALUZero(ALUZero),
			.Uncondbranch(Uncondbranch),
			.NextPC(NextPC)
	);

	initial begin
		// Initialize Inputs
		#0
		CurrentPC = 0;
		SignExtImm64 = 0;
		Branch = 0;
		ALUZero = 0;
		Uncondbranch = 0;
		
		// Add stimulus here
		$display("Init Memory with some useful data");
		
        //case1: in this test all control values are 0
		//output should be NextPC= CurrentPC+4;
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hFAFAF0F0ABCD0201, 64'hFFFFFFFF20003002, 1'b0, 1'b0,1'b0};
        #6
        passTest(NextPC, 64'hFAFAF0F0ABCD0205, "NextPC is correct for case  1");
	   
	   //case 2a: in this test  unconditional branch  is 1 and the rest are 0
       //output should be NextPC= CurrentPC+SignExtImm64;
         #100
         {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1234567800100200, 64'h1234567101010000, 1'b0, 1'b0,1'b1};
         #6
         passTest(NextPC, 64'h2468ACD901110200, "NextPC is correct for case  4");
		
		
		//case 3:in this test  ALUZero is 1 and the rest are 0
		//output should be NextPC= CurrentPC+4;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1234567800000007, 64'h876543210000000, 1'b0, 1'b1,1'b0};
        #6//B in hexcode so it  is 11
        passTest(NextPC, 64'h123456780000000B, "NextPC is correct for case  3");

		
		//case 4a: in this test unconditional branch is 1 and ALUZero is 1 and the rest are 0
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h1111222200000003, 64'h1111222200000004, 1'b0, 1'b1,1'b1};
        #6
        passTest(NextPC, 64'h2222333300000007, "NextPC is correct for case  5");
		
		//case 5a: in this test branch is 1 and the rest are 0
        //output should be NextPC= CurrentPC+4;
        #100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hBABEFFFF00000002, 64'hBAB0BABE00000030, 1'b1, 1'b0,1'b0};
        #6
         passTest(NextPC, 64'hBABEFFFF00000006, "NextPC is correct for case  2");
                
		//case 6: in this test unconditional branch is 1 and branch is 1 and the rest are 0
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'h333344440A000008, 64'h3333444400000001, 1'b1, 1'b0,1'b1};
        #6
        passTest(NextPC, 64'h777788880A000009, "NextPC is correct for case  6");
		
		//case 7: in this test control values are all 1
		//output should be NextPC= CurrentPC+SignExtImm64;
		#100
        {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hA531111100001231, 64'h00000000FFFF0003, 1'b1, 1'b1,1'b0};
        #6
        passTest(NextPC, 64'hA531111100001234, "NextPC is correct for case  7");
        
        //case 8: 
        //output should be NextPC= CurrentPC+SignExtImm64;
         #100
         {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'hABCD123400011111, 64'h0000123400010101, 1'b1, 1'b1,1'b1};
         #6
         passTest(NextPC, 64'hABCD246800021212, "NextPC is correct for case  8");
                
	end
      
endmodule

