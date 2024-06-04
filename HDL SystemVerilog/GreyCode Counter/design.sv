// Aaron Luna
// Assignment 2 Top
// Behavorial 

module graycode_counter_top(
    input logic clk,        // Clock input
    input logic rst,        // Reset input
    input logic rstN,       // Reset Now input
    input logic dir,        // Direction input
    output logic [2:0] out  // 3-bit grayscale output
);

    // Define an 3-bit counter and set to 000
    logic [2:0] count = 3'b000;
  
    // Always block to increment the count on each rising edge of the clock
  always_ff @(posedge clk or posedge rst or negedge rstN) begin
    if (!rstN) begin
      count = 3'b000;
    end
    else begin
      case (count)
        3'b000: // When 000 then reset to 001 if direction is forward
          if (dir==0) begin
            count = 001;  
          end
          else begin // Goes to previous number if direction is backward
            count = 3'b100;
          end
        3'b001: // When 001 then reset to 011 if direction is forward
          if (dir==0) begin
            count = 011;  
          end
          else begin // Goes to previous number if direction is backward
            count = 3'b000;
          end 
        3'b011: // When 011 then reset to 010 if direction is forward
          if (dir==0) begin
            count = 010;  
          end
          else begin // Goes to previous number if direction is backward
            count = 3'b001;
          end 
        3'b010: // When 010 then reset to 110 if direction is forward
          if (dir==0) begin
            count = 110;  
          end
          else begin // Goes to previous number if direction is backward
            count = 3'b011;
          end 
        3'b110: // When 110 then reset to 111 if direction is forward
          if (dir==0) begin
            count = 111;  
          end
          else begin // Goes to previous number if direction is backward
            count = 3'b010;
          end 
        3'b111: // When 111 then reset to 101 if direction is forward
          if (dir==0) begin
            count = 101;  
          end
          else begin // Goes to previous number if direction is backward
            count = 3'b110;
          end 
        3'b101: // When 101 then reset to 100 if direction is forward
          if (dir==0) begin
            count = 100;  
          end
          else begin // Goes to previous number if direction is backward
            count = 3'b111;
          end 
        3'b100: // When 100 then reset to 000 if direction is forward
          if (dir==0) begin
            count = 000;  
          end
          else begin // Goes to previous number if direction is backward
            count = 3'b101;
          end 
      endcase; // End of case statements
    end // end of else statement
  end // end of always_ff

    // Assign output with the count value
    assign out = count;

endmodule