module Frog_Movement(
  input            i_Clk,
  input            i_Frog_Up,
  input            i_Frog_Dn,
  input            i_Frog_Lt,
  input            i_Frog_Rt,
  input            i_Has_Collided,
  output reg       o_Draw_Frog,
  output reg [6:0] o_Score = c_SCORE_INI,
  output reg [9:0] o_Frog_X = c_X_BASE_POSITION,
  output reg [9:0] o_Frog_Y = c_Y_BASE_POSITION 
);

  wire w_Frog_En;
  reg [31:0] r_Counter = 0;

  // Only allow Frog to move if only one button is pushed (use XOR for exclusive movement).
  assign w_Frog_En = i_Frog_Up ^ i_Frog_Dn ^ i_Frog_Lt ^ i_Frog_Rt;

  always @(posedge i_Clk) 
  begin

    // Simple delay counter for movement
    if (w_Frog_En == 1)
    begin
      if (r_Counter == COUNT_LIMIT) 
      begin
        r_Counter <= 0;
      end 
      else 
      begin
        r_Counter <= r_Counter + 1;
      end
    end

    if (i_Has_Collided == 1'b1) 
    begin
      o_Frog_Y <= c_Y_BASE_POSITION;
      o_Frog_X <= c_X_BASE_POSITION;
      o_Score <= 1'b0;
    end
    else
    begin
      // Move Frog up: check bounds to avoid underflow
      if (i_Frog_Up == 1'b1 && r_Counter == COUNT_LIMIT && o_Frog_Y > 0) 
      begin
        if (o_Frog_Y > TILE_SIZE) 
        begin
          o_Frog_Y <= o_Frog_Y - TILE_SIZE; // Move frog up
        end
        else
        begin
          o_Frog_Y <= c_Y_BASE_POSITION;
          o_Frog_X <= c_X_BASE_POSITION;
          o_Score <= o_Score + 1'b1;
        end
      end 
      // Move Frog down: check that the frog doesn't exceed screen height
      else if (i_Frog_Dn == 1'b1 && r_Counter == COUNT_LIMIT && o_Frog_Y < (V_VISIBLE_AREA - TILE_SIZE)) 
      begin
        o_Frog_Y <= o_Frog_Y + TILE_SIZE; // Move frog down
      end 
      // Move Frog left: check bounds to avoid underflow
      else if (i_Frog_Lt == 1'b1 && r_Counter == COUNT_LIMIT && o_Frog_X > 0) 
      begin
        o_Frog_X <= o_Frog_X - TILE_SIZE; // Move frog left
      end 
      // Move Frog right: check that the frog doesn't exceed screen width
      else if (i_Frog_Rt == 1'b1 && r_Counter == COUNT_LIMIT && o_Frog_X < (H_VISIBLE_AREA - TILE_SIZE)) 
      begin
        o_Frog_X <= o_Frog_X + TILE_SIZE; // Move frog right
      end
    end
  end

  // Control the visibility of the frog on the screen
  always @(posedge i_Clk)
  begin
    // Ensure frog stays within boundaries and is drawn when in bounds
    if ((o_Frog_X >= 0) && (o_Frog_X <= (H_VISIBLE_AREA - TILE_SIZE)) && (o_Frog_Y >= 0) && (o_Frog_Y <= (V_VISIBLE_AREA - TILE_SIZE)))
    begin
      o_Draw_Frog <= 1'b1;
    end
    else
    begin
      o_Draw_Frog <= 1'b0;
    end
  end

endmodule