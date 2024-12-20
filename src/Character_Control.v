///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// Controls frog movements and respawns.
//
// I/Os:
// Needs a Clock, a wire for each direction, one for collision state and another for game state as inputs.
// As outputs, it needs registers for leveling up, scoring, frog X and Y positions.
// 
// Behavior:
// This module waits for the game to start (You can't move elsewhere).
// It puts the frog back in its initial position if you get hit by a car.
// It checks the direction inputs if the frog doesn't exceed the screen limits, 
// the position is set to the new one (plus or minus one tile size).
// If the frog reaches the top screen, the score is incremented by one, and leveling up is momentarily set to 1.
// Finally, it sets the score to 1 (first level) while the game has not started.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Character_Control #(
    parameter C_SCORE_INI       = 1,
    parameter C_X_BASE_POSITION = 320,
    parameter C_Y_BASE_POSITION = 416,
    parameter COUNT_LIMIT       = 3125000,
    parameter TILE_SIZE         = 32,
    parameter V_VISIBLE_AREA    = 480,
    parameter H_VISIBLE_AREA    = 640
)(
    // Clock
    input            i_Clk,

    // input for each directions (linked to switches)
    input            i_Frog_Up,
    input            i_Frog_Dn,
    input            i_Frog_Lt,
    input            i_Frog_Rt,

    // state of collision
    input            i_Has_Collided,

    // game state
    input            i_Game_Active,

    // state when finishing a level
    output reg       o_Level_Up     = 0,

    // Variable storing score
    output reg [3:0] o_Score        = C_SCORE_INI,

    // Left corner of the frog (Player)
    output reg [9:0] o_Frog_X       = C_X_BASE_POSITION,
    output reg [8:0] o_Frog_Y       = C_Y_BASE_POSITION 
);

    wire       w_Frog_En;               // Frog in movement

    reg        r_state          = 1'b0; // Actual frog state 
    reg [31:0] r_Counter        = 0;    // Delay counter

    // Only allow Frog to move if only one button is pushed (use XOR for exclusive movement).
    assign w_Frog_En = (i_Frog_Up ^ i_Frog_Dn) ^ (i_Frog_Lt ^ i_Frog_Rt);

    always @(posedge i_Clk) 
    begin
        // Only enable inputs if the game has started
        if (i_Game_Active == 1) 
        begin
            o_Level_Up <= 0;
            r_state <= w_Frog_En;
            // Simple delay counter for movement
            if ((r_Counter == COUNT_LIMIT) && (w_Frog_En == 1) && (r_state == 0))
            begin
                r_Counter <= 0;
            end
            else if (r_Counter < COUNT_LIMIT)
            begin
                r_Counter <= r_Counter + 1;
            end

            // Check collision state
            if (i_Has_Collided == 1'b1) 
            begin
                o_Frog_Y <= C_Y_BASE_POSITION;
                o_Frog_X <= C_X_BASE_POSITION;
            end
            else
            begin
                // Move Frog up: check bounds to avoid underflow
                if (i_Frog_Up == 1'b1 && r_Counter == COUNT_LIMIT && o_Frog_Y > 0 && r_state == 0 && (i_Frog_Up ^ i_Frog_Dn) && w_Frog_En) 
                begin
                    if (o_Frog_Y > TILE_SIZE) 
                    begin
                        o_Frog_Y <= o_Frog_Y - TILE_SIZE; // Move frog up
                    end
                    else
                    begin
                        o_Frog_Y <= C_Y_BASE_POSITION;    // Reset position when top reached
                        o_Frog_X <= C_X_BASE_POSITION;
                        o_Score  <= o_Score + 1'b1;       // Add 1 to score when top reached
                        o_Level_Up <= 1;
                    end
                end 
                // Move Frog down: check that the frog doesn't exceed screen height
                else if (i_Frog_Dn == 1'b1 && r_Counter == COUNT_LIMIT && o_Frog_Y < (V_VISIBLE_AREA - TILE_SIZE) && r_state == 0 && (i_Frog_Up ^ i_Frog_Dn) && w_Frog_En) 
                begin
                    o_Frog_Y <= o_Frog_Y + TILE_SIZE; // Move frog down
                end 
                // Move Frog left: check bounds to avoid underflow
                else if (i_Frog_Lt == 1'b1 && r_Counter == COUNT_LIMIT && o_Frog_X > 0 && r_state == 0 && (i_Frog_Lt ^ i_Frog_Rt) && w_Frog_En) 
                begin
                    o_Frog_X <= o_Frog_X - TILE_SIZE; // Move frog left
                end 
                // Move Frog right: check that the frog doesn't exceed screen width
                else if (i_Frog_Rt == 1'b1 && r_Counter == COUNT_LIMIT && o_Frog_X < (H_VISIBLE_AREA - TILE_SIZE) && r_state == 0 && (i_Frog_Lt ^ i_Frog_Rt) && w_Frog_En) 
                begin
                    o_Frog_X <= o_Frog_X + TILE_SIZE; // Move frog right
                end
            end
        end 
        else 
        begin
            o_Score <= 1'b1; // Keep Score at 1 when game not started
        end
    end

endmodule