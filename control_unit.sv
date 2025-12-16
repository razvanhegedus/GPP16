module control_unit (
    input  logic [4:0] opcode,   // 5-bit opcode (future-proof)
    output logic       we3,        // register write enable
    output logic [4:0] alu_func    // ALU operation select
);

    // Opcode definitions (full ISA declared, subset implemented)
    localparam OP_ADD = 5'd0;
    localparam OP_SUB = 5'd1;
    localparam OP_MUL = 5'd2;
    localparam OP_DIV = 5'd3;
    localparam OP_MOD = 5'd4;
    localparam OP_MOV = 5'd5;
    localparam OP_HLT = 5'd31;     // reserved

    always_comb begin
        // defaults
        we3      = 1'b0;
        alu_func = 5'd0;

        case (opcode)
            OP_ADD: begin
                we3      = 1'b1;
                alu_func = OP_ADD;
            end
            OP_SUB: begin
                we3      = 1'b1;
                alu_func = OP_SUB;
            end
            OP_MUL: begin
                we3      = 1'b1;
                alu_func = OP_MUL;
            end
            OP_DIV: begin
                we3      = 1'b1;
                alu_func = OP_DIV;
            end
            OP_MOD: begin
                we3      = 1'b1;
                alu_func = OP_MOD;
            end
            OP_MOV: begin
                we3      = 1'b1;
                alu_func = OP_MOV; // handled in datapath
            end
            default: begin
                we3      = 1'b0;   // unimplemented instructions
            end
        endcase
    end

endmodule

