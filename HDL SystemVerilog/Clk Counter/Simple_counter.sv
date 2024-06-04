// A simple Counter
// Behavioral
// Mark W. Welker  

module counter (count, clk, reset);
output logic [7:0] count;
input logic clk, reset;


parameter tpd_reset_to_count = 3;
parameter tpd_clk_to_count   = 2;


always @ (posedge clk or posedge reset)
  if (reset)
     count = #tpd_reset_to_count 8'h00;
  else
     count <= #tpd_clk_to_count count+1;

endmodule
