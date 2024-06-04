// Code your testbench here
// or browse Examples
// a simple verilog counter testbench

//Mark W. Welker

//`timescale 1ns / 1ns

`include "Simple_counter.sv"

module test_counter (clk,reset);

output logic clk, reset;
  
initial begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
      #350
      $finish;
    end


initial // Clock generator
  begin
    clk = 0;
    forever #10 clk = !clk;
  end
  
initial	// Test stimulus
  begin
    reset = 0;
    #5 reset = 1;
    #4 reset = 0;
  end
  
endmodule 