module alu_16 (
    input  logic [15:0] a,
    input  logic [15:0] b,
    input  logic [4:0]  func,   // keep 5-bit func for Milestone 3
    output logic [15:0] y
);

    // ALU operation encoding (subset)
    localparam ADD = 5'd0;
    localparam SUB = 5'd1;
    localparam MUL = 5'd2;
    localparam DIV = 5'd3;
    localparam MOD = 5'd4;

    always_comb begin
        y = 16'd0;

        case (func)
            ADD: y = a + b;
            SUB: y = a - b;
            MUL: y = a * b;
            DIV: y = (b != 0) ? a / b : 16'd0;
            MOD: y = (b != 0) ? a % b : 16'd0;
            default: y = 16'd0; // not implemented yet
        endcase
    end

endmodule

