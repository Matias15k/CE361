`timescale 1ns / 1ps

module gcd_tb;

    reg clk;
    reg rst;
    reg start;
    reg [31:0] a, b;
    wire [31:0] result;
    wire done;

    // Instantiate the GCD module
    gcd uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a(a),
        .b(b),
        .result(result),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
       $dumpfile("waveform.vcd");
       $dumpvars(0, gcd_tb);
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        $display("Starting GCD testbench...");
        rst = 1;
        start = 0;
        a = 0;
        b = 0;
        #10 rst = 0;

        // Test case 1: GCD(48, 18) = 6
        a = 32'd48;
        b = 32'd18;
        start = 1;
        #10 start = 0;
        wait(!done);
        wait(done);       
        $display($time,, "GCD(48, 18) = %d (0x%h)", result, result);

        // Test case 2: GCD(56, 98) = 14
        a = 32'd56;
        b = 32'd98;
        start = 1;
        #10 start = 0;
        wait(!done);       
        wait(done);
        $display($time,, "GCD(56, 98) = %d (0x%h)", result, result);

        // Test case 3: GCD(101, 103) = 1
        a = 32'd101;
        b = 32'd103;
        start = 1;
        #10 start = 0;
        wait(!done);       
        wait(done);
        $display($time,, "GCD(101, 103) = %d (0x%h)", result, result);

        $finish;
    end

endmodule

