// This module show the score on the board by using the 7 segments.
// The first one would be for the tens and the second one for the units.
// It uses the score incremented in Frog_Movement.v as input.
module Segment_Display (
  // Clock
  input        i_Clk,

  // Score from Frog_Movement
  input  [6:0] i_Score,

  // Tens Segment
  output       o_Segment_A,
  output       o_Segment_B,
  output       o_Segment_C,
  output       o_Segment_D,
  output       o_Segment_E,
  output       o_Segment_F,
  output       o_Segment_G,

  // Units Segment
  output       o_Segment2_A,
  output       o_Segment2_B,
  output       o_Segment2_C,
  output       o_Segment2_D,
  output       o_Segment2_E,
  output       o_Segment2_F,
  output       o_Segment2_G);

  reg [6:0]    i_Binary_Num    = 7'd0;    // Store units 
  reg [6:0]    i_Binary_Num2   = 7'd0;    // Store tens
  reg [6:0]    r_Hex_Encoding;            // Use to activate segments separately
  reg [6:0]    r_Hex_Encoding2;

  always @(posedge i_Clk)
  begin
    i_Binary_Num <= i_Score;
    // Check if above 10
    if (i_Binary_Num >= 4'b1010)
    begin
      i_Binary_Num2 <= i_Binary_Num2 + 1;
      i_Binary_Num  <= i_Binary_Num - 10;
    end
    else if (i_Binary_Num2 == 4'b1010) // Check if equal to 100
    begin
      i_Binary_Num2 <= 0;
      i_Binary_Num  <= 0;
    end
  end

  // Loop to activate segments corresponding to the decimal value
  always @(posedge i_Clk)
    begin
      case (i_Binary_Num)
        4'b0000 : r_Hex_Encoding2 <= 7'h7E;
        4'b0001 : r_Hex_Encoding2 <= 7'h30;
        4'b0010 : r_Hex_Encoding2 <= 7'h6D;
        4'b0011 : r_Hex_Encoding2 <= 7'h79;
        4'b0100 : r_Hex_Encoding2 <= 7'h33;          
        4'b0101 : r_Hex_Encoding2 <= 7'h5B;
        4'b0110 : r_Hex_Encoding2 <= 7'h5F;
        4'b0111 : r_Hex_Encoding2 <= 7'h70;
        4'b1000 : r_Hex_Encoding2 <= 7'h7F;
        4'b1001 : r_Hex_Encoding2 <= 7'h7B;
      endcase
      case (i_Binary_Num2)
        4'b0000 : r_Hex_Encoding <= 7'h7E;
        4'b0001 : r_Hex_Encoding <= 7'h30;
        4'b0010 : r_Hex_Encoding <= 7'h6D;
        4'b0011 : r_Hex_Encoding <= 7'h79;
        4'b0100 : r_Hex_Encoding <= 7'h33;
        4'b0101 : r_Hex_Encoding <= 7'h5B;
        4'b0110 : r_Hex_Encoding <= 7'h5F;
        4'b0111 : r_Hex_Encoding <= 7'h70;
        4'b1000 : r_Hex_Encoding <= 7'h7F;
        4'b1001 : r_Hex_Encoding <= 7'h7B;
      endcase
    end

  assign o_Segment_A  = ~r_Hex_Encoding[6];
  assign o_Segment_B  = ~r_Hex_Encoding[5];
  assign o_Segment_C  = ~r_Hex_Encoding[4];
  assign o_Segment_D  = ~r_Hex_Encoding[3];
  assign o_Segment_E  = ~r_Hex_Encoding[2];
  assign o_Segment_F  = ~r_Hex_Encoding[1];
  assign o_Segment_G  = ~r_Hex_Encoding[0];
  assign o_Segment2_A = ~r_Hex_Encoding2[6];
  assign o_Segment2_B = ~r_Hex_Encoding2[5];
  assign o_Segment2_C = ~r_Hex_Encoding2[4];
  assign o_Segment2_D = ~r_Hex_Encoding2[3];
  assign o_Segment2_E = ~r_Hex_Encoding2[2];
  assign o_Segment2_F = ~r_Hex_Encoding2[1];
  assign o_Segment2_G = ~r_Hex_Encoding2[0];

endmodule