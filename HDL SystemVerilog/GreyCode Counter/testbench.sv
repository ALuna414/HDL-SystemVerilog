// Aaron Luna
// Assignment 2 Test Bench
// Behavorial 


module graycode_counter_testBench;

    // Define parameters
    parameter CLK_PERIOD = 10;  
    parameter SIM_TIME = 70;   

    // Declare signals
    logic clk = 0;    // Clock
    logic rst = 0;  // Reset
    logic rstN = 1; // Reset Now, change this value between 0 & 1 for assignment tasks
    logic dir = 0;    // Direction, change this value between 0 & 1 for assignment tasks
    logic [2:0] out;  // Ouput

    initial begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
      #10000
      $finish;
    end
  
    // Instantiate output module w/ help of GPT
    graycode_counter_top dut (
        .clk(clk),
        .rst(rst),
        .rstN(rstN),
        .dir(dir),
        .out(out)
    );

    // Clock generation
    always #((CLK_PERIOD/2)) clk = ~clk;
  
    // Test case
    initial begin
        // Initialize signals
        rst = 1;
        #10 rst = 0;

        // Wait for some time to observe the output
        #SIM_TIME;

        $finish;
    end
  
    // Displays output
    always @(posedge clk) begin
      $display("Graycode Counter #: %b", out);
    end

endmodule