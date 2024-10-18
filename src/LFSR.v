module LFSR #(
    parameter             NUM_BITS    = 4
    )(
    input                 i_Clk,
 
    output [NUM_BITS-1:0] o_LFSR_Data,
);
 
    reg    [NUM_BITS:1]   r_LFSR      = 0;
    reg                   r_XNOR;
 
 
    // Purpose: Load up LFSR with Seed if Data Valid (DV) pulse is detected.
    // Othewise just run LFSR when enabled.
    always @(posedge i_Clk)
    begin
        r_LFSR <= {r_LFSR[NUM_BITS-1:1], r_XNOR};
    end
 
    // Change pseudo-randomly the value of a register that is used as a random value.
    always @(*)
    begin
        r_XNOR = r_LFSR[4] ^~ r_LFSR[3];
    end
 
 
    assign o_LFSR_Data = r_LFSR[NUM_BITS:1];
 
endmodule // LFSR