`timescale 1ns/1ps

module tb_cpu;

    logic clk;
    logic rst;

    // ======================
    // DUT INSTANTIATION
    // ======================
    GPP16microprocessor dut (
        .clk(clk),
        .rst(rst)
    );

    // ======================
    // CLOCK GENERATION
    // ======================
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 100 MHz clock
    end

    // ======================
    // RESET SEQUENCE
    // ======================
    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    // ======================
    // SIMULATION CONTROL
    // ======================
    initial begin
        // Let the program execute
        #300;

        $display("Simulation finished successfully.");
        $finish;
    end

endmodule

