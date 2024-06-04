// Code your design here
module top;

 logic [31:0] count;
   	counter U1(count, clk, reset);
	test_counter T1(clk,reset);


endmodule