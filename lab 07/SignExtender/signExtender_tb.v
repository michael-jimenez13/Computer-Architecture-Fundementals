`timescale 1ns / 1ps

`define STRLEN 32

module signExtender_tb();

//inputs
reg [31:0] imm32;
reg [10:0] ctrl;
//outputs
wire [63:0] Bout;

//pass and fail outputs 
    task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

SignExtender test(Bout, imm32, ctrl);


initial begin 
//initialize inputs
    imm32 = 0;
    ctrl = 0;
   #10;
   
   //add stimulus
  //D-instruction
  { ctrl, imm32, Bout} = {11'b111110000X0, 32'd332, 64'd332};
           #4;
           passTest(imm32, 32'd332, "Initial Value Check 1", passed);
           #6; Clk = 0; #10; Clk = 1;
           passTest(imm32, 32'd332, "Value Updated 1", passed);
 //CB instruction          
 { ctrl, imm32, Bout} = {11'b10110100XXX, 32'd2133, 64'd2133;
                     #4;
                     passTest(imm32, 32'd2133, "Initial Value Check 1", passed);
                     #6; Clk = 0; #10; Clk = 1;
                     passTest(imm32, 32'd2133, "Value Updated 1", passed);
// B Instruction
{ ctrl, imm32, Bout} = {11'b000101XXXXX, 32'd22, 64'd22;
                     #4;
                     passTest(imm32, 32'd22, "Initial Value Check 1", passed);
                     #6; Clk = 0; #10; Clk = 1;
                     passTest(imm32, 32'd22, "Value Updated 1", passed);
//R shift instruction
{ ctrl, imm32, Bout} = {11'b1101001101X, 32'd763, 64'd763;
                     #4;
                     passTest(imm32, 32'd763, "Initial Value Check 1", passed);
                     #6; Clk = 0; #10; Clk = 1;
                     passTest(imm32, 32'd763, "Value Updated 1", passed);
//R imm instruction
{ ctrl, imm32, Bout} = {11'b1XX10XX00X, 32'd2143, 64'd2143
                     #4;
                     passTest(imm32, 32'd2143, "Initial Value Check 1", passed);
                     #6; Clk = 0; #10; Clk = 1;
                     passTest(imm32, 32'd2143, "Value Updated 1", passed);
end
endmodule
