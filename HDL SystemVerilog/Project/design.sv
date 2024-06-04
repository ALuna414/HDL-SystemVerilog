// Aaron Luna
// HDL 4321 Fall 2023
// Final Project Modules
// 12/1/23
//
// Project Outline: 
// Build a simplistic processing engine hat contains a matrix ALU, a math ALU, instruction fetch,
// execution, and memory interface. The matrix unit will perform matrix multiplication, scaler
// multiplication, subtraction, addition, and transposition.
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Top Module 
// 
// File Purpose: Top module that connects all the modules
// Collaborator: Professor Welker's Given Code
// 
// Main memory MUST be allocated in the mainmemory module as per teh next line.
//  logic [255:0]MainMemory[12]; // this is the physical memory
//
//
//
module top ();

  logic [255:0] InstructDataOut;
  logic [255:0] MemDataOut;
  logic [255:0] ExeDataOut;
  logic [255:0] IntDataOut;
  logic [255:0] MatrixDataOut;
  logic nRead,nWrite,nReset,Clk;
  logic [15:0] address;

  logic Fail;

  InstructionMemory  U1(Clk,InstructDataOut, address, nRead,nReset);

  MainMemory  U2(Clk,MemDataOut,ExeDataOut, address, nRead,nWrite, nReset);

  Execution  U3(Clk,InstructDataOut,MemDataOut,MatrixDataOut,IntDataOut,ExeDataOut, address, nRead,nWrite, nReset);

  MatrixAlu  U4(Clk,MatrixDataOut,ExeDataOut, address, nRead,nWrite, nReset);

  IntegerAlu  U5(Clk,IntDataOut,ExeDataOut, address, nRead,nWrite, nReset);

  TestMatrix  UTest(Clk,nReset);

    // this block checks to make certain the proper data is in the memory.
  always @(InstructDataOut) begin 
    if (InstructDataOut[31:0] == 32'hff000000) begin // we are about to execute the stop
        
    // Print out the entire contents of main memory so I can copy and paste.
    $display ( "memory location 0 = %h", U2.MainMemory[0]);
    $display ( "memory location 1 = %h", U2.MainMemory[1]);
    $display ( "memory location 2 = %h", U2.MainMemory[2]);
    $display ( "memory location 3 = %h", U2.MainMemory[3]);
    $display ( "memory location 4 = %h", U2.MainMemory[4]);
    $display ( "memory location 5 = %h", U2.MainMemory[5]);
    $display ( "memory location 6 = %h", U2.MainMemory[6]);
    $display ( "memory location 7 = %h", U2.MainMemory[7]);
    $display ( "memory location 8 = %h", U2.MainMemory[8]);
    $display ( "memory location 9 = %h", U2.MainMemory[9]);
    $display ( "memory location 10 = %h", U2.MainMemory[10]);
    $display ( "memory location 11 = %h", U2.MainMemory[11]);
    $display ( "memory location 12 = %h", U2.MainMemory[12]);
    $display ( "memory location 13 = %h", U2.MainMemory[13]);

    $display ( "Internal reg location 0 = %h", U3.InternalReg[0]);
    $display ( "Internal reg location 1 = %h", U3.InternalReg[1]);
    $display ( "Internal reg location 2 = %h", U3.InternalReg[2]);
    $display ( "Internal reg location 3 = %h", U3.InternalReg[3]);
      
    if (U2.MainMemory[0] == 256'h0008000c00080006000c0010000d0009000a00090005000d000c0003000a0006)
      $display ( "memory location 0 is Correct");
    else begin Fail = 1; $display ( "memory location 0 is Wrong"); end
    if (U2.MainMemory[1] == 256'h000300040007000800070008000e000700100009000c000b000c000500050006)
      $display ( "memory location 1 is Correct");
    else begin Fail = 1;$display ( "memory location 1 is Wrong"); end
    if (U2.MainMemory[2] == 256'h000b0010000f000e00130018001b0010001a00120011001800180008000f000c)
      $display ( "memory location 2 is Correct");
    else begin Fail = 1;$display ( "memory location 2 is Wrong"); end
    if (U2.MainMemory[3] == 256'h000300040007000800070008000e000700100009000c000b000c000500050006)
      $display ( "memory location 3 is Correct");
    else begin Fail = 1;$display ( "memory location 3 is Wrong"); end
    if (U2.MainMemory[4] == 256'h000b0013001a00180010001800120008000f001b0011000f000e00100018000c)
      $display ( "memory location 4 is Correct");
    else begin Fail = 1;$display ( "memory location 4 is Wrong"); end
    if (U2.MainMemory[5] == 256'h036602260307028b025801ca02c0021e02ae01f802fa024a02aa01cc029e0230)
      $display ( "memory location 5 is Correct");
    else begin Fail = 1;$display ( "memory location 5 is Wrong"); end
    if (U2.MainMemory[6] == 256'h02c0016201b001ae018000ca010000f601c400e40117011502100114015c0150)
      $display ( "memory location 6 is Correct");
    else begin Fail = 1;$display ( "memory location 6 is Wrong"); end
    if (U2.MainMemory[7] == 256'h00000000000000000000000000000000000000000000000002fa024a029e0230)
      $display ( "memory location 7 is Correct");
    else begin Fail = 1;$display ( "memory location 7 is Wrong"); end
    if (U2.MainMemory[8] == 256'h0000000000000000000000000000000000000000000000000000000000000000)
      $display ( "memory location 8 is Correct");
    else begin Fail = 1;$display ( "memory location 8 is Wrong"); end
    if (U2.MainMemory[9] == 256'h0000000000000000000000000000000000000000000000000000000000000000)
      $display ( "memory location 9 is Correct");
    else begin Fail = 1;$display ( "memory location 9 is Wrong"); end
    if (U2.MainMemory[10][15:0] == 16'h0024)
      $display ( "memory location 10 is Correct");
    else begin Fail = 1;$display ( "memory location 10 is Wrong"); end
    if (U2.MainMemory[11][15:0] == 16'h0000)
      $display ( "memory location 11 is Correct");
    else begin Fail = 1;$display ( "memory location 11 is Wrong"); end

    if (U3.InternalReg[0][15:0] == 16'h0013)
      $display ( "Interal reg location 0 is Correct");
    else begin Fail = 1; $display ( "Internal Register 0 is Wrong"); end
    if (U3.InternalReg[1] == 256'h0039004c0085009800850098010a0085013000ab00e400d100e4005f005f0072)
      $display ( "Internal Reg location 1 is Correct");
    else begin Fail = 1; $display ( "Internal Register 1 is Wrong"); end
    if (U3.InternalReg[2][15:0] == 16'h001e)
      $display ( "Internal Reg location 2 is Correct");
    else begin Fail = 1; $display ( "Internal Register 2 is Wrong"); end

        if (Fail) begin
        $display("********************************************");
        $display(" Project did not return the proper values");
        $display("********************************************");
        end
        else begin
        $display("********************************************");
        $display(" Project PASSED memory check");
        $display("********************************************");
        end     
    end // end of if
  end // end of always block

endmodule
//
// End of Top Module
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Instruction Module 
// 
// File Purpose: ROM that holds instructions to be executed
// Collaborator: Professor Welker's Given Code
// 
//
// Location parameters
parameter MainMemEn = 0;
parameter InstrMemEn = 1;
parameter MatrixAluEn = 2;
parameter IntAluEn = 3;
parameter RegisterEn = 4;
parameter ExecuteEn = 5;

// Alu Register setup 
// Same register sequence for both ALU's 
parameter AluStatusIn = 0;
parameter AluStatusOut = 1;
parameter ALU_Source1 = 2;
parameter ALU_Source2 = 3;
parameter ALU_Result = 4;
    
// add the data at location 0 to the data at location 1 and place result in location 2
parameter Instruct1 = 32'h 03_02_00_01; //Add first matrix to second matrix store in memory
parameter Instruct2 = 32'h 10_10_0a_0b; //Add 16 bit numbers in location a to b store in temp register
parameter Instruct3 = 32'h 04_03_02_00; //Subtract 1st matrix from result in Step1 and store somewhere else in mem. 
parameter Instruct4 = 32'h 05_04_02_00; //Transpose the result from step 1 store in memory
parameter Instruct5 = 32'h 07_11_03_10; //ScaleImm result in step 3 by result from step 2, store in a matrix register
parameter Instruct6 = 32'h 00_05_04_03; //Multiply result from step 4 by result in step 3, store in memory. 4x4 * 4x4
parameter Instruct7 = 32'h 01_06_04_03; //Multiply result from step 6 by result in step 5, store in memory. 4x2 * 2x4
parameter Instruct8 = 32'h 02_07_04_03; //Multiply result from step 5 by result in step 4, store in memory. 2x4 * 4x2
parameter Instruct9 = 32'h 12_0a_01_00; //Multiply int value in memory location 0 to location 1. Store in memory location 0x0A
parameter Instruct10 = 32'h 11_12_0a_01;//Subtract int value in memory location 01 from memory location 0x0A and store in a reg
parameter Instruct11 = 32'h 13_0b_0a_12;//Divide Memory location 0x0A by register in step 8, store it in location 0x0B
parameter Instruct12 = 32'h FF_00_00_00; // stop
// End of parameter declarations
  

module InstructionMemory(Clk, InstructDataOut, address, nRead, nReset); 
// NOTE the lack of datain and write. This is because this is a ROM model
  
    input logic nRead, nReset, Clk;
    input logic [15:0] address;
    
    output logic [255:0] InstructDataOut;
      
  logic [255:0]InstructMemory[12]; // Physical memory

// This memory is designed to be driven into a data multiplexor. 
    always_ff @(negedge Clk or negedge nReset) begin
      if(!nReset) begin
        InstructDataOut = 0;
      end 
  
      else begin
        if(address[15:12] == InstrMemEn) begin // Talking to Instruction IntstrMemEn
          if(!nRead) begin
            InstructDataOut <= InstructMemory[address[11:0]]; // data will reamin on dataout until it is changed.
          end // end if !nRead
        end //end if Address||
      end // end else
    end // from negedge nRead
  
    always @(negedge nReset) begin // set in the default instructions 
      InstructMemory[0] = Instruct1;    
      InstructMemory[1] = Instruct2;    
      InstructMemory[2] = Instruct3;
      InstructMemory[3] = Instruct4;  
      InstructMemory[4] = Instruct5;
      InstructMemory[5] = Instruct6;
      InstructMemory[6] = Instruct7;
      InstructMemory[7] = Instruct8;
      InstructMemory[8] = Instruct9;
      InstructMemory[9] = Instruct10;
      InstructMemory[10] = Instruct11;
      InstructMemory[11] = Instruct12;
    end // end nededge nReset 
  
endmodule 
//
// End of Instruction Module
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MainMemory Module 
// 
// File Purpose: Main memory modules that holds 256 bit data
// Collaborator: Professor Welker's Given Code
//
//
//
module MainMemory(Clk, MemDataOut,DataIn, address, nRead, nWrite, nReset);
    input logic nRead, nWrite, nReset, Clk;
    input logic [15:0] address;
    input logic [255:0] DataIn;
  
    output logic [255:0] MemDataOut;
    
    logic [255:0]MainMemory[14]; // Physical memory

	always_ff @(negedge Clk or negedge nReset) begin
    	if (!nReset) begin
            // Initialize MainMemory with specific values
			MainMemory[0] = 256'h0008_000c_0008_0006_000c_0010_000d_0009_000a_0009_0005_000d_000c_0003_000a_0006;
			MainMemory[1] = 256'h0003_0004_0007_0008_0007_0008_000e_0007_0010_0009_000c_000b_000c_0005_0005_0006; 
			MainMemory[2] = 256'h0;
			MainMemory[3] = 256'h0;
			MainMemory[4] = 256'h0;
			MainMemory[5] = 256'h0;
			MainMemory[6] = 256'h0;
			MainMemory[7] = 256'h0;
			MainMemory[8] = 256'h4;
			MainMemory[9] = 256'hb;
			MainMemory[10] = 256'h0;
			MainMemory[11] = 256'h0;
		
            // Reset MemDataOut to 0
      		MemDataOut=0;
        end // end !nReset

        else if (address[15:12] == MainMemEn) begin // Talking to Instruction
            if (!nRead) begin
              MemDataOut <= MainMemory[address[11:0]]; // Data will remain on dataout until it is changed.
            end 
		
        	if(!nWrite)begin
		      MainMemory[address[11:0]] <= DataIn;
			end
        end // end Adi == MainMemEn
	end // from negedge nRead	
  
endmodule
//
// End of MainMem Module
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ExecutionEngine Module 
// 
// File Purpose: Execution engine for controlling data flow of simple processor 
// Collaborator: None
// 
//
// Location parameters
//parameter MainMemEn = 0;
//parameter InstrMemEn = 1;
//parameter MatrixAluEn = 2;
//parameter IntAluEn = 3;
//parameter RegisterEn = 4;
//parameter ExecuteEn = 5;

//Opcode Parameters
parameter Source1 = 0;
parameter Source2 = 1;
parameter Result = 2;
parameter StatusIn = 3;
parameter StatusOut = 4;
parameter Stop = 8'hff;


module Execution(Clk,InstructDataOut,MemDataOut,MatrixDataOut,IntDataOut,ExeDataOut, address, nRead,nWrite, nReset);

    input logic Clk, nReset;
    input logic [255:0] InstructDataOut, MemDataOut, IntDataOut, MatrixDataOut;
  
    output logic nRead, nWrite;
    output logic [15:0] address;
    output logic [255:0] ExeDataOut; 
  
    logic [7:0] opcode;
    logic [15:0] PC;
    logic [31:0] instruction;
    logic [255:0] executionReg[5];
    logic [255:0] InternalReg[5];

	// Enum states
    enum {readInstr,readInstrData,decodeInstr,findSource1,findDestSource1,moveSource1,endMove1,
          findSource2,moveImm,getSource2,findDestSource2,moveSource2,endMove2,doMath,waitResult,finishMath,readResult,
          moveResult,resultFinish} currentState, nextState;
  
  always_ff @ (posedge Clk) begin
      if(!nReset) begin
        // set all to 0
        currentState = readInstr;
        executionReg[Source1] = 0;
        executionReg[Source2] = 0;
        executionReg[Result] = 0;
        PC = 0;
      end // end !nReset
      
      else 
        currentState = nextState;
        
      if(nReset) begin 
        case(currentState)
         
          readInstr: begin 
              address[15:12] = InstrMemEn;
              address[11:0] = PC;
              nRead = 0;
              nextState = readInstrData;
          end // end readInstruction case
  
  	      readInstrData: begin
              instruction = InstructDataOut; 
              opcode = instruction[31:24];
              nRead = 1;
              nextState = decodeInstr;
          end // end readInstructionData case
          
          decodeInstr: begin
              if(opcode == Stop) 
                $finish;
              else
                nextState = findSource1;
          end // end decodeInstruction case
          
          findSource1: begin
              if(instruction[15:12] == MainMemEn) begin
                address[15:12] = MainMemEn; 
                executionReg[Source1] = MemDataOut; 
              end 
            
              else begin
                address[15:12] = RegisterEn;
                executionReg[Source1] = InternalReg[address[11:0]];
              end 
            
              address[11:0] = instruction[11:8]; 
              nRead = 0;
              nextState = findDestSource1;
          end // end findSource case
          
          findDestSource1: begin
              if(opcode[7:4] == 0) begin
                address[15:12] = MatrixAluEn;
              end
            
              if (opcode[7:4] == 1) begin 
                address[15:12] = IntAluEn;
              end
            
              address[11:0] = 0;
              ExeDataOut = executionReg[Source1];
              nextState = moveSource1;
          end // end findDestSource1 
            
          moveSource1: begin
              nWrite = 0;
              nextState = endMove1;
          end // end moveSource1
            
          endMove1: begin
              nRead = 1;
              nWrite = 1;
              nextState = findSource2;
          end // end endMove1
          
          findSource2: begin
              if(opcode == 8'h07) 
                nextState = moveImm;
              else begin
                if(instruction[7:4] == 4'h0) 
                  address[15:12] = MainMemEn; 
                else
                  address[15:12] = RegisterEn;
                  
                 address[11:0] = instruction[3:0]; 
                 nRead = 0;
                 nextState = getSource2;
              end
          end // end findSource2
          
          moveImm: begin
              ExeDataOut = instruction[7:0];
              address[11:0] = 1; 
              nextState = moveSource2;
          end // end moveImm
                   
          getSource2: begin
              if(address[15:12] == MainMemEn)
                executionReg[Source2] = MemDataOut; 
              else
                executionReg[Source2] = InternalReg[address[11:0]];
            
              nextState = findDestSource2;  
          end // end getSource2
          
          findDestSource2: begin
              if(opcode[7:4] == 0)
                address[15:12] = MatrixAluEn;
              if (opcode[7:4] == 1)
                address[15:12] = IntAluEn;
            
              address[11:0] = 1; 
              ExeDataOut = executionReg[Source2];
              nextState = moveSource2;
          end // end findDestSource2
          
          moveSource2: begin
              nWrite = 0;
              nextState = endMove2;
          end // end moveSource2 
            
          endMove2: begin
              nRead = 1;
              nWrite = 1;
              nextState = doMath;
          end // end endMove2
          
          doMath: begin
              if(opcode[7:4] == 0)
                address[15:12] = MatrixAluEn;
              else if (opcode[7:4] == 1)
                address[15:12] = IntAluEn;
                
              address[11:0] = 3;
              ExeDataOut = opcode;
              nWrite = 0;
              nextState = waitResult;
            end // end doMath
          
          waitResult: begin
              nWrite = 1;
              address[11:0] = 4; 
              nRead = 0;
            
              if(address[15:12] == MatrixAluEn) begin
                if(MatrixDataOut == 256'h0) 
                  nextState = waitResult;
                else if (MatrixDataOut == 256'h1) 
                  nextState = finishMath; 
              end
                
              if(address[15:12] == IntAluEn) begin
                if(IntDataOut == 0) 
                  nextState = waitResult;
                else if(IntDataOut == 1) 
                  nextState = finishMath; 
              end
            end // end waitResult
            
            finishMath: begin
                address[11:0] = 2; 
                nRead = 0;
                nextState = readResult;
            end // finishMath
            
            readResult: begin
                if(opcode[7:4] == 0)
                  executionReg[Result] = MatrixDataOut;
                else if (opcode[7:4] == 1)
                  executionReg[Result] = IntDataOut;  
              
                nextState = moveResult;
            end // end readResult
            
            moveResult: begin
                if(instruction[23:20] == 0) begin 
                  address[15:12] = MainMemEn;
                  address[11:0] = instruction[19:16]; 
                  ExeDataOut = executionReg[Result];
                  nWrite = 0;
                end
              
                else 
                  InternalReg[instruction[19:16]] = executionReg[Result];     
                nextState = resultFinish;
            end // end moveResult
            
            resultFinish: begin
                nRead = 1;
                nWrite = 1;
                address = 0;
                PC = PC + 1;
                nextState = readInstr;
            end // end resultFinsish
          
            default: $display("The default case");
        endcase 
        currentState = nextState;
      end // end if nReset
    end // end always_ff
endmodule
//
// End of ExecutionEngine Module
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// MatrixALU Module 
// 
// File Purpose: Takes operands and performs Matrix related operations. 
// Collaborator: None
// 
//
//
// This is the memory locations for the system.
/////////////////////////////////////////////
//parameter MainMemEn = 0;
//parameter InstrMemEn = 1;
//parameter AluEn = 2;
//parameter IntAlu = 3;
//parameter Int_Register = 4;
//parameter Exe_Engine = 5
//
parameter MMult1 = 8'h00; //4x4 times 4x4
parameter MMult2 = 8'h01; //4x2 times 2x4
parameter MMult3 = 8'h02; //2x4 times 4x2
parameter Madd = 8'h03; //4x4 + 4x4
parameter Msub = 8'h04; //4x4 - 4x4
parameter Mtranspose = 8'h05; //Rows & Collumns swap
parameter MScale = 8'h06; //4x4 time a
parameter MScaleImm = 8'h07; //4x4 times immediate

parameter source1 = 0;
parameter source2 = 1;
parameter result = 2;
parameter statusIn = 3;
parameter statusOut = 4;

  
module MatrixAlu(Clk, MatrixDataOut, ExeDataOut, address, nRead, nWrite, nReset);
  
    input logic Clk, nRead, nWrite, nReset;
    input logic [15:0] address;
    input logic [255:0] ExeDataOut;
  
    output logic [255:0] MatrixDataOut;
  
    logic [7:0] operation;
    logic [15:0] source1Matrix [3:0][3:0];
    logic [15:0] source2Matrix [3:0][3:0];
    logic [15:0] resultMatrix [3:0][3:0];
    logic [255:0] matrixALUReg[5];
  
    assign operation = matrixALUReg[statusIn];
  
    int i, j, k, rows, cols;
    int rowA[], colB[];
    int temp[][], temp2[][];
    int fourByTwo[][], twoByFour[][];
  
    always_comb begin
      if(!nReset) begin
        matrixALUReg[source1] = 256'h0;
        matrixALUReg[source2] = 256'h0;
        matrixALUReg[result] = 256'h0;
        matrixALUReg[statusIn] = 256'h0;
        matrixALUReg[statusOut] = 256'h0;
        
        resultMatrix[0] = '{16'h0,16'h0,16'h0,16'h0};
        resultMatrix[1] = '{16'h0,16'h0,16'h0,16'h0};
        resultMatrix[2] = '{16'h0,16'h0,16'h0,16'h0};
        resultMatrix[3] = '{16'h0,16'h0,16'h0,16'h0};
      end // end !nReset
      
      if(address[15:12] == MatrixAluEn) begin
        if(!nRead) begin
          MatrixDataOut = matrixALUReg[address[11:0]];
        end // end !nRead
        
        if(nWrite == 0) begin
          matrixALUReg[statusOut] = 256'h0; 
          matrixALUReg[address[11:0]] = ExeDataOut;
          
          if(address[11:0] == 0) begin
            source1Matrix[0][0] = ExeDataOut[15:0];
            source1Matrix[0][1] = ExeDataOut[31:16];
            source1Matrix[0][2] = ExeDataOut[47:32];
            source1Matrix[0][3] = ExeDataOut[63:48];   
            source1Matrix[1][0] = ExeDataOut[79:64];
            source1Matrix[1][1] = ExeDataOut[95:80];
            source1Matrix[1][2] = ExeDataOut[111:96];
            source1Matrix[1][3] = ExeDataOut[127:112];
            source1Matrix[2][0] = ExeDataOut[143:128];
            source1Matrix[2][1] = ExeDataOut[159:144];
            source1Matrix[2][2] = ExeDataOut[175:160];
            source1Matrix[2][3] = ExeDataOut[191:176];      
            source1Matrix[3][0] = ExeDataOut[207:192];
            source1Matrix[3][1] = ExeDataOut[223:208];
            source1Matrix[3][2] = ExeDataOut[239:224];
            source1Matrix[3][3] = ExeDataOut[255:240];
          end // end Matrix 1
          
          if(address[11:0] == 1) begin
            source2Matrix[0][0] = ExeDataOut[15:0];
            source2Matrix[0][1] = ExeDataOut[31:16];
            source2Matrix[0][2] = ExeDataOut[47:32];
            source2Matrix[0][3] = ExeDataOut[63:48];    
            source2Matrix[1][0] = ExeDataOut[79:64];
            source2Matrix[1][1] = ExeDataOut[95:80];
            source2Matrix[1][2] = ExeDataOut[111:96];
            source2Matrix[1][3] = ExeDataOut[127:112];   
            source2Matrix[2][0] = ExeDataOut[143:128];
            source2Matrix[2][1] = ExeDataOut[159:144];
            source2Matrix[2][2] = ExeDataOut[175:160];
            source2Matrix[2][3] = ExeDataOut[191:176];     
            source2Matrix[3][0] = ExeDataOut[207:192];
            source2Matrix[3][1] = ExeDataOut[223:208];
            source2Matrix[3][2] = ExeDataOut[239:224];
            source2Matrix[3][3] = ExeDataOut[255:240];
          end // end Matrix 2
        end // end nWrite == 0
    
        if (address[11:0] == 3) begin
          case(operation) 
            MMult1: begin
              for (i = 0; i < 4; i++) begin
                for (j = 0; j < 4; j++) begin
                  resultMatrix[i][j] = 0; 
                
                  for (k = 0; k < 4; k++) begin      
                    resultMatrix[i][j] += source1Matrix[i][k] * source2Matrix[k][j];
                  end // end of for k
                end // end of for j
              end // end of for i
          
              matrixALUReg[statusOut] = 256'h1;
            end // end MMult1
        
            MMult2: begin
              for (i = 0; i < 4; i++) begin 
                for (j = 0; j < 4; j++) begin 
                  temp[i][j] = 0;
                
                  for (k = 0; k < 2; k++) begin
                    rowA[k] = fourByTwo[i][k];
                    colB[k] = twoByFour[k][j];
                    temp[i][j] += rowA[k] * colB[k];
                  end // end of for k
                end // end of for j
              end // end of for i
              
              for (i = 0; i < 4; i++) begin 
                for (j = 0; j < 4; j++) begin 
                  resultMatrix[i][j] = temp[i][j];
                end 
              end

            end // end MMult2
        
            MMult3: begin
              /*for (i = 0; i < 2; i++) begin 
                for (j = 0; j < 2; j++) begin
                  temp2[i][j] = 0;
              
                  for (k = 0; k < 4; k++) begin 
                    temp2[i][j] += twoByFour[i][k] * fourByTwo[k][j];
                  end // end of for k
                end // end of for j
              end // end of for i
          
              resultMatrix[0] = {temp2[1][1],temp2[1][0],temp2[0][1],temp2[0][0]};
            end // end of MMult3 */
            
            matrixALUReg[result][15:0] = 
            (source1Matrix[0][0]*source2Matrix[0][0]) + (source1Matrix[0][1]*source2Matrix[1][0]) + (source1Matrix[0][2]*source2Matrix[2][0]) + (source1Matrix[0][3]*source2Matrix[3][0]);
                   matrixALUReg[result][31:16] = 
            (source1Matrix[0][0]*source2Matrix[0][1]) + (source1Matrix[0][1]*source2Matrix[1][1]) + (source1Matrix[0][2]*source2Matrix[2][1]) + (source1Matrix[0][3]*source2Matrix[3][1]);
                   matrixALUReg[result][47:32] = 
            (source1Matrix[1][0]*source2Matrix[0][0]) + (source1Matrix[1][1]*source2Matrix[1][0]) + (source1Matrix[1][2]*source2Matrix[2][0]) + (source1Matrix[1][3]*source2Matrix[3][0]);
                   matrixALUReg[result][63:48] = 
            (source1Matrix[1][0]*source2Matrix[0][1]) + (source1Matrix[1][1]*source2Matrix[1][1]) + (source1Matrix[1][2]*source2Matrix[2][1]) + (source1Matrix[1][3]*source2Matrix[3][1]);
                   
                    matrixALUReg[result][255:64] = 0;
            matrixALUReg[statusOut] = 256'h1;
                    end 
        
            Madd: begin 
              matrixALUReg[result] = matrixALUReg[source1] + matrixALUReg[source2];
              matrixALUReg[statusOut] = 256'h1;
            end // end Madd
    
            Msub: begin 
              matrixALUReg[result] = matrixALUReg[source1] - matrixALUReg[source2];
              matrixALUReg[statusOut] = 256'h1;
            end // end Msub
        
            Mtranspose: begin
              for(rows = 0; rows < 4; rows++) begin
                for(cols = 0; cols < 4; cols++) begin 
                  resultMatrix[rows][cols] = source1Matrix[cols][rows];
                end // end of for cols
              end // end of for rows
          
              matrixALUReg[result] = {resultMatrix[3][3], resultMatrix[3][2], resultMatrix[3][1], resultMatrix[3][0],
                                      resultMatrix[2][3], resultMatrix[2][2], resultMatrix[2][1], resultMatrix[2][0],
                                      resultMatrix[1][3], resultMatrix[1][2], resultMatrix[1][1], resultMatrix[1][0],
                                      resultMatrix[0][3], resultMatrix[0][2], resultMatrix[0][1], resultMatrix[0][0]};
              matrixALUReg[statusOut] = 256'h1;
            end // end Mtranspose
            
            MScale: begin
              matrixALUReg[result][15:0] = source1Matrix[0][0] * matrixALUReg[source2];
              matrixALUReg[result][31:16] = source1Matrix[0][1] * matrixALUReg[source2];
              matrixALUReg[result][47:32] = source1Matrix[0][2] * matrixALUReg[source2];
              matrixALUReg[result][63:48] = source1Matrix[0][3] * matrixALUReg[source2];  
              matrixALUReg[result][79:64] = source1Matrix[1][0] * matrixALUReg[source2];
              matrixALUReg[result][95:80] = source1Matrix[1][1] * matrixALUReg[source2];
              matrixALUReg[result][111:96] = source1Matrix[1][2] * matrixALUReg[source2];
              matrixALUReg[result][127:112] = source1Matrix[1][3] * matrixALUReg[source2];   
              matrixALUReg[result][143:128] = source1Matrix[2][0] * matrixALUReg[source2];
              matrixALUReg[result][159:144] = source1Matrix[2][1] * matrixALUReg[source2];
              matrixALUReg[result][175:160] = source1Matrix[2][2] * matrixALUReg[source2];
              matrixALUReg[result][191:176] = source1Matrix[2][3] * matrixALUReg[source2];    
              matrixALUReg[result][207:192] = source1Matrix[3][0] * matrixALUReg[source2];
              matrixALUReg[result][223:208] = source1Matrix[3][1] * matrixALUReg[source2];
              matrixALUReg[result][239:224] = source1Matrix[3][2] * matrixALUReg[source2];
              matrixALUReg[result][255:240] = source1Matrix[3][3] * matrixALUReg[source2];
              
              matrixALUReg[statusOut] = 256'h1;
            end // end MScale
            
            MScaleImm: begin
              matrixALUReg[result][15:0] = source1Matrix[0][0] * matrixALUReg[source2];
              matrixALUReg[result][31:16] = source1Matrix[0][1] * matrixALUReg[source2];
              matrixALUReg[result][47:32] = source1Matrix[0][2] * matrixALUReg[source2];
              matrixALUReg[result][63:48] = source1Matrix[0][3] * matrixALUReg[source2];    
              matrixALUReg[result][79:64] = source1Matrix[1][0] * matrixALUReg[source2];
              matrixALUReg[result][95:80] = source1Matrix[1][1] * matrixALUReg[source2];
              matrixALUReg[result][111:96] = source1Matrix[1][2] * matrixALUReg[source2];
              matrixALUReg[result][127:112] = source1Matrix[1][3] * matrixALUReg[source2];     
              matrixALUReg[result][143:128] = source1Matrix[2][0] * matrixALUReg[source2];
              matrixALUReg[result][159:144] = source1Matrix[2][1] * matrixALUReg[source2];
              matrixALUReg[result][175:160] = source1Matrix[2][2] * matrixALUReg[source2];
              matrixALUReg[result][191:176] = source1Matrix[2][3] * matrixALUReg[source2];     
              matrixALUReg[result][207:192] = source1Matrix[3][0] * matrixALUReg[source2];
              matrixALUReg[result][223:208] = source1Matrix[3][1] * matrixALUReg[source2];
              matrixALUReg[result][239:224] = source1Matrix[3][2] * matrixALUReg[source2];
              matrixALUReg[result][255:240] = source1Matrix[3][3] * matrixALUReg[source2];
                           
              matrixALUReg[statusOut] = 256'h1;
            end // end MScaleImm
          
            default: $display("DEFAULT OF THE Matrix ALU");
          endcase
        end // end address == StatusIn
      end // end address == matrixAluEN
    end // end always_comb
    
endmodule
//        
// End of MatrixALU Module
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IntegerALU Module 
// 
// File Purpose: Takes operands and performs Integer related operations. 
// Collaborator: None
// 

`timescale 1ns / 1ps

//Integer ALU Opcodes
parameter ADD = 8'h10; 
parameter SUB = 8'h11;
parameter MUL = 8'h12; 
parameter DIV = 8'h13;
        
parameter source_1 = 0;
parameter source_2 = 1;
parameter results = 2;
parameter status_In = 3;
parameter status_Out = 4;
        
        
module IntegerAlu(Clk,IntDataOut,ExeDataOut, address, nRead,nWrite, nReset);  
  
    input logic Clk, nRead ,nWrite, nReset; 
    input logic [15:0] address; 
    input logic [255:0] ExeDataOut;

    output logic [255:0] IntDataOut;
  
    logic [7:0] operation; 
    logic [255:0] IntAluReg[5];
  
    assign operation = IntAluReg[status_In];
  
  always_comb begin
    // Reset signal low, reset all ALU regs
    if(nReset == 0) begin 
      IntAluReg[source_1] = 256'h0;
      IntAluReg[source_2] = 256'h0;
      IntAluReg[results] = 256'h0;
      IntAluReg[status_In] = 256'h0;
      IntAluReg[status_Out] = 256'h0;
    end // end if nReset == 0
    
    if(address[15:12] == IntAluEn) begin
      if(nWrite == 0) begin 
        IntAluReg[address[11:0]] = ExeDataOut;
        IntAluReg[status_Out] = 0;
      end // end nWrite
            
      if(nRead == 0) 
        IntDataOut = IntAluReg[address[11:0]];
      
      if (address[11:0] == 3) begin
        case(operation)
            ADD: begin 
              IntAluReg[results] = IntAluReg[source_1] + IntAluReg[source_2];
              IntAluReg[status_Out] = 1;
            end // end ADD
          
            SUB: begin 
              IntAluReg[results] = IntAluReg[source_1] - IntAluReg[source_2];
              IntAluReg[status_Out] = 1;
            end // end SUB
          
            MUL: begin 
              IntAluReg[results] = IntAluReg[source_1] * IntAluReg[source_2];
              IntAluReg[status_Out] = 1;
            end // end MUL
          
            DIV: begin 
              IntAluReg[results] = IntAluReg[source_2] / IntAluReg[source_1];
              IntAluReg[status_Out] = 1;
            end // end DIV
          
            default: $display("DEFAULT OF THE INT ALU");
        endcase 
      end // end address == 3
    end // end address == IntALuEn
  end // end always_comb
        
endmodule 
//    
// End of IntegerALU Module
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////