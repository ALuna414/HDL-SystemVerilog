// Aaron Luna
// HDL 4321 Fall 2023
// Generic Test bench It drives only clock and reset
// TestBench from Canvas
// 12/1/23


module TestMatrix  (Clk,nReset);

	output logic Clk,nReset; // Driving these signals from here. 
  
    // This needed for EDAPlaygorund
    initial begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
      #2000
      $finish;
    end

	initial begin
	   Clk = 0;
	   nReset = 1;
	#5 nReset = 0;
	#5 nReset = 1;
	end
	
	always  #5 Clk = ~Clk;
	
endmodule