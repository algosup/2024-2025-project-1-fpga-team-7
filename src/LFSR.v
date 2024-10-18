// Description: 
// A LFSR or Linear Feedback Shift Register is a quick and easy way to generate
// pseudo-random data inside of an FPGA.  The LFSR can be used for things like
// counters, test patterns, scrambling of data, and others.  This module
// creates an LFSR whose width gets set by a parameter.  The o_LFSR_Done will
// pulse once all combinations of the LFSR are complete.  The number of clock
// cycles that it takes o_LFSR_Done to pulse is equal to 2^g_Num_Bits-1.  For
// example setting g_Num_Bits to 5 means that o_LFSR_Done will pulse every
// 2^5-1 = 31 clock cycles.  o_LFSR_Data will change on each clock cycle that
// the module is enabled, which can be used if desired.
module LFSR #(
    parameter             NUM_BITS    = 4
    )(
    input                 i_Clk,
 
    output [NUM_BITS-1:0] o_LFSR_Data,
);
 
    reg    [NUM_BITS:1]   r_LFSR      = 0;
    reg                   r_XNOR;


    // Change pseudo-randomly the value of a register that is used as a random value.
    always @(*)
    begin
        r_LFSR <= {r_LFSR[NUM_BITS-1:1], r_XNOR};
        case (NUM_BITS)
            3: 
            begin
                r_XNOR = r_LFSR[3] ^~ r_LFSR[2];
            end
            4: 
            begin
                r_XNOR = r_LFSR[4] ^~ r_LFSR[3];
            end
            5: 
            begin
                r_XNOR = r_LFSR[5] ^~ r_LFSR[3];
            end
            6: 
            begin
                r_XNOR = r_LFSR[6] ^~ r_LFSR[5];
            end
            7: 
            begin
                r_XNOR = r_LFSR[7] ^~ r_LFSR[6];
            end
            8: 
            begin
                r_XNOR = r_LFSR[8] ^~ r_LFSR[6] ^~ r_LFSR[5] ^~ r_LFSR[4];
            end
            9: 
            begin
                r_XNOR = r_LFSR[9] ^~ r_LFSR[5];
            end
            10: 
            begin
                r_XNOR = r_LFSR[10] ^~ r_LFSR[7];
            end
            11: 
            begin
                r_XNOR = r_LFSR[11] ^~ r_LFSR[9];
            end
            12: 
            begin
                r_XNOR = r_LFSR[12] ^~ r_LFSR[6] ^~ r_LFSR[4] ^~ r_LFSR[1];
            end
            13: 
            begin
                r_XNOR = r_LFSR[13] ^~ r_LFSR[4] ^~ r_LFSR[3] ^~ r_LFSR[1];
            end
            14: 
            begin
                r_XNOR = r_LFSR[14] ^~ r_LFSR[5] ^~ r_LFSR[3] ^~ r_LFSR[1];
            end
            15: 
            begin
                r_XNOR = r_LFSR[15] ^~ r_LFSR[14];
            end
            16: 
            begin
                r_XNOR = r_LFSR[16] ^~ r_LFSR[15] ^~ r_LFSR[13] ^~ r_LFSR[4];
            end
            17: 
            begin
                r_XNOR = r_LFSR[17] ^~ r_LFSR[14];
            end
            18: 
            begin
                r_XNOR = r_LFSR[18] ^~ r_LFSR[11];
            end
            19: 
            begin
                r_XNOR = r_LFSR[19] ^~ r_LFSR[6] ^~ r_LFSR[2] ^~ r_LFSR[1];
            end
            20: 
            begin
                r_XNOR = r_LFSR[20] ^~ r_LFSR[17];
            end
            21: 
            begin
                r_XNOR = r_LFSR[21] ^~ r_LFSR[19];
            end
            22: 
            begin
                r_XNOR = r_LFSR[22] ^~ r_LFSR[21];
            end
            23: 
            begin
                r_XNOR = r_LFSR[23] ^~ r_LFSR[18];
            end
            24: 
            begin
                r_XNOR = r_LFSR[24] ^~ r_LFSR[23] ^~ r_LFSR[22] ^~ r_LFSR[17];
            end
            25: 
            begin
                r_XNOR = r_LFSR[25] ^~ r_LFSR[22];
            end
            26: 
            begin
                r_XNOR = r_LFSR[26] ^~ r_LFSR[6] ^~ r_LFSR[2] ^~ r_LFSR[1];
            end
            27: 
            begin
                r_XNOR = r_LFSR[27] ^~ r_LFSR[5] ^~ r_LFSR[2] ^~ r_LFSR[1];
            end
            28: 
            begin
                r_XNOR = r_LFSR[28] ^~ r_LFSR[25];
            end
            29: 
            begin
                r_XNOR = r_LFSR[29] ^~ r_LFSR[27];
            end
            30: 
            begin
                r_XNOR = r_LFSR[30] ^~ r_LFSR[6] ^~ r_LFSR[4] ^~ r_LFSR[1];
            end
            31: 
            begin
                r_XNOR = r_LFSR[31] ^~ r_LFSR[28];
            end
            32: 
            begin
                r_XNOR = r_LFSR[32] ^~ r_LFSR[22] ^~ r_LFSR[2] ^~ r_LFSR[1];
            end
 
        endcase // case (NUM_BITS)
    end // always @ (*)
 
 
    assign o_LFSR_Data = r_LFSR[NUM_BITS:1];
 
endmodule // LFSR