module Frog_Movement(
   input            i_Clk,
   input [8:0]      i_Frog_X,
   input [8:0]      i_Frog_Y,
   input            i_Frog_Up,
   input            i_Frog_Dn,
   input            i_Frog_Lt,
   input            i_Frog_Rt,
   output reg       o_Draw_Frog,
   output reg [8:0] o_Frog_X,
   output reg [8:0] o_Frog_Y);

  wire w_Frog_En;

  reg [31:0] r_Counter = 0;

  // Only allow Frogs to move if only one button is pushed.
  // ^ is an XOR bitwise operation.
  assign w_Frog_En = i_Frog_Up ^ i_Frog_Dn ^ i_Frog_Lt ^ i_Frog_Rt;

  always @(posedge i_Clk) 
  begin
    if (r_Counter == COUNT_LIMIT)
    begin
      if (w_Frog_En == 1)
        r_Counter <= 0;
    end
    else
    r_Counter <= r_Counter + 1;

    if (i_Frog_Up == 1'b1 &&
        r_Counter == COUNT_LIMIT &&
        o_Frog_Y !== 0)
      o_Frog_Y <= o_Frog_Y - 32;
  end

  always @(posedge i_Clk)
  begin
    if ((i_Frog_X > 0) && (i_Frog_X < H_VISIBLE_AREA - TILE_SIZE) &&
        (i_Frog_Y > 0) && (i_Frog_Y < V_VISIBLE_AREA - TILE_SIZE))
      o_Draw_Frog <= 1'b1;
    else
      o_Draw_Frog <= 1'b0;
  end

endmodule