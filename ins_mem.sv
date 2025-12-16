module ins_mem (
    input  logic [15:0] addr,
    output logic [15:0] instr
);
    logic [15:0] rom [0:7];

    initial begin
        rom[0] = 16'b00000_001_010_011_00; // ADD R1,R2,R3
        rom[1] = 16'b00001_100_001_010_00; // SUB R4,R1,R2
        rom[2] = 16'b00010_101_001_001_00; // MUL R5,R1,R1
        rom[3] = 16'b11111_000_000_000_00; // HLT (unused)
    end

    assign instr = rom[addr[2:0]];

endmodule

