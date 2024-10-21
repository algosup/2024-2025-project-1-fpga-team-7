///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// This module shows the score on the board by using the 7 segments.
//
// I/Os:
// It needs a Clock and a score register as inputs.
// As outputs, it needs seven segments to display a digital score.
// 
// Behavior:
// It encodes a hexadecimal value in a register according to the score (from 1 to A).
// It is encoded on 7 bits, one for each segment.
// It returns the opposite value of this value (it appears on the board when opposite).
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Seven_Segments_Display(
    // Clock
    input       i_Clk,

    // Score lesser than 16
    input [3:0] i_Score,

    // Physical display
    output      o_Segment_A,
    output      o_Segment_B,
    output      o_Segment_C,
    output      o_Segment_D,
    output      o_Segment_E,
    output      o_Segment_F,
    output      o_Segment_G
);

    // Store a value on 7 bits, 1 for each segment
    reg [6:0]    r_Hex_Encoding;
  
    // Purpose: Creates a case statement for all possible input binary numbers.
    // Drives r_Hex_Encoding appropriately for each input combination.
    always @(posedge i_Clk)
    begin
        case (i_Score)
            4'b0001 : r_Hex_Encoding <= 7'h30;
            4'b0010 : r_Hex_Encoding <= 7'h6D;
            4'b0011 : r_Hex_Encoding <= 7'h79;
            4'b0100 : r_Hex_Encoding <= 7'h33;          
            4'b0101 : r_Hex_Encoding <= 7'h5B;
            4'b0110 : r_Hex_Encoding <= 7'h5F;
            4'b0111 : r_Hex_Encoding <= 7'h70;
            4'b1000 : r_Hex_Encoding <= 7'h7F;
            4'b1001 : r_Hex_Encoding <= 7'h7B;
            default : r_Hex_Encoding <= 7'h47;  // Above 10 display F for finish
        endcase
    end

    assign o_Segment_A = ~r_Hex_Encoding[6];
    assign o_Segment_B = ~r_Hex_Encoding[5];
    assign o_Segment_C = ~r_Hex_Encoding[4];
    assign o_Segment_D = ~r_Hex_Encoding[3];
    assign o_Segment_E = ~r_Hex_Encoding[2];
    assign o_Segment_F = ~r_Hex_Encoding[1];
    assign o_Segment_G = ~r_Hex_Encoding[0];
  
endmodule