module reg_file #(
    parameter bits = 16,
    parameter N    = 3
)(
    input  logic [N-1:0] RA1,
    input  logic [N-1:0] RA2,
    input  logic [N-1:0] WA3,
    input  logic         WE3,
    input  logic         clk,
    input  logic         rst,
    input  logic [bits-1:0] WD3,
    output logic [bits-1:0] RD1,
    output logic [bits-1:0] RD2
);

    logic [bits-1:0] sram [0:(1<<N)-1];
    integer i;
    
     
    
    always_ff @(posedge clk or posedge rst) begin
    	if (rst) begin
        	for (i = 0; i < (1<<N); i = i + 1)
            		sram[i] <= '0;

        // PRELOAD VALUES FOR ALU DEMO
        	sram[2] <= 16'd7;   // R2 = 7
        	sram[3] <= 16'd3;   // R3 = 3
    		end
    	else if (WE3) begin
        sram[WA3] <= WD3;
    	end
     end


    assign RD1 = sram[RA1];
    assign RD2 = sram[RA2];

endmodule

