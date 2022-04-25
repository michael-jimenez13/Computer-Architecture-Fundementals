`timescale 1ns / 1ps

`define STRLEN 32

module aluControl();
    //to prove all cases work
   task passTest;
		input [3:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;

		if(actualOut == expectedOut) begin $display ("%s passed", testType); end
		else $display ("%s failed: %d should be %d", testType,  actualOut, expectedOut);
	endtask

	// Inputs
	reg [1:0] ALUop;
	reg [10:0] Opcode;

	// Outputs
	wire [3:0] ALUctrl;

	// Instantiate the Unit Under Test (UUT)
	ALUControl test (
		.ALUop(ALUop), 
		.Opcode(Opcode), 
		.ALUctrl(ALUctrl)
	);

	initial begin
		// Initialize Inputs
		ALUop = 0;
		Opcode = 0;

		// Add stimulus here
		$display("Init Memory with some useful data");
		
        //#1-Ldur or Stur -aluctrl = 0010
        {ALUop, Opcode} = {2'b00, 11'bXXXXXXXXXXX};
        #4
        passTest(ALUctrl, 4'b0010, "ALUControl is correct for case  1");

		
        #50 //#2-CBZ - aluctrl = 0111
        {ALUop, Opcode} = {2'b01, 11'bXXXXXXXXXXX};
        #4
       passTest(ALUctrl, 4'b0111, "ALUControl is correct for case 2");

		
		#50;//#3 -sub - aluctrl=0110
		{ALUop, Opcode} = {2'b10, 11'b11001011000};
       #4
       passTest(ALUctrl, 4'b0110, "ALUControl is correct for case 3");

        #50;//#4 -or - aluctrl =0001
        {ALUop, Opcode} = {2'b10, 11'b10101010000};
	    #4
	    passTest(ALUctrl, 4'b0001, "ALUControl is correct for Case 4");

        #50;//#5 and- aluctrl = 0000
        {ALUop, Opcode} = {2'b10, 11'b10001010000};
        #4
        passTest(ALUctrl, 4'b0000, "ALUControl is correct for case 5");

		
        #50;//#6-add - aluctrl=0010
        {ALUop, Opcode} = {2'b10, 11'b10001011000};
        #4
        passTest(ALUctrl, 4'b0010, "ALUControl is correct for case 6");
      	 
	     #50;//#7- or -  aluctrl = 0001
         {ALUop, Opcode} = {2'b10, 11'b10101010000};
	    #4
	     passTest(ALUctrl, 4'b0001, "ALUControl is correct for case 7");

        #50;//#8-add - aluctrl=0010
        {ALUop, Opcode} = {2'b10, 11'b10001011000};
		#4
		passTest(ALUctrl, 4'b0010, "ALUControl is correct for case 8");

        #50;//#9-sub - aluctrl = 0110
        {ALUop, Opcode} = {2'b10, 11'b11001011000}; 
       #4
       passTest(ALUctrl, 4'b0110, "ALUControl is correct for case 9");



	end
      
endmodule

