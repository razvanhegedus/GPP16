module register #(
    parameter bits = 16
)(
    input  logic [bits-1:0] D,
    input  logic            clk,
    input  logic            rst,
    input  logic            en,
    output logic [bits-1:0] Q
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            Q <= '0;
        else if (en)
            Q <= D;
    end
endmodule

