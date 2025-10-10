`timescale 1ns / 1ps



module gcd_tb;

    reg clk;
    reg rst;
    reg start;
    reg [31:0] a, b;
    wire [31:0] result;
    wire done;

    // Instantiate the GCD module
    gcd_subtract uut (
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

    // --- add near top of module ---
    integer total_cycles;

    // Count cycles after reset is deasserted
    initial total_cycles = 0;
    always @(posedge clk) if (!rst) total_cycles <= total_cycles + 1;

    // Test sequence
    initial begin
        $display("Starting GCD testbench...");
        rst = 1;
        start = 0;
        a = 0;
        b = 0;
        #10 rst = 0;

        // Test case 2: GCD(56, 98) = 14
        a = 32'd56;
        b = 32'd98;
        start = 1;
        #10 start = 0;
        wait(!done);       
        wait(done);
        $display($time,, "GCD(56, 98) => got %0d (0x%h), expect 14 (0x%h)", result, result, 32'd14);

        $display("TOTAL cycles (reset deassert -> finish) = %0d", total_cycles);
        // If your sim clock is 10 ns:
        $display("TOTAL sim time ~= %0d ns", total_cycles*10);
        $finish;
    end

endmodule

