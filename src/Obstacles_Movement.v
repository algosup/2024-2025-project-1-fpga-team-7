///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// Cars movements, speeds, and directions.
//
// I/Os:
// It needs a Clock, a wire for the reverse state, and one to store the current score.
// As outputs, it needs a register for each car X position. 
// 
// Behavior:
// It checks the score to update the car speed.
// It increments the cars' X positions according to a multiplier and their previous position.
// It teleports the cars from one side of the screen to another.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Obstacles_Movement#(
    parameter C_BASE_CAR_SPEED              = 781250,
    parameter H_VISIBLE_AREA                = 640,
    parameter TILE_SIZE                     = 32,
    parameter NUM_BITS                      = 4
)(
    // Clock
    input                     i_Clk,

    // Reverse cars
    input      [NUM_BITS-1:0] i_Reverse,

    // Score
    input      [3:0]          i_Score,

    // Cars X positions
    output reg [9:0]          o_Car_X_0,
    output reg [9:0]          o_Car_X_1     = (TILE_SIZE),
    output reg [9:0]          o_Car_X_2     = 2 * (TILE_SIZE),
    output reg [9:0]          o_Car_X_3     = 3 * (TILE_SIZE),
    output reg [9:0]          o_Car_X_4     = 6 * (TILE_SIZE),
    output reg [9:0]          o_Car_X_5     = 7 * (TILE_SIZE),
    output reg [9:0]          o_Car_X_6     = 8 * (TILE_SIZE),
    output reg [9:0]          o_Car_X_7     = 9 * (TILE_SIZE),
);

    reg [19:0]           r_Count      = 0;                  // Global counter for movement timing
    reg [19:0]           r_Car_Speed  = C_BASE_CAR_SPEED;   // Set the initial speed based on the clock

    // Task to update the car's X position
    task Update_Car_Position;
        input  [9:0]    i_Car_X;
        input           i_Reverse;
        input  [2:0]    i_Car_Speed_Multiplier; // Speed multiplier based on the car index
        output [9:0]    o_Car_X;                // Modified output to hold the new position
        begin
            if (i_Reverse == 0) 
            begin
                o_Car_X = i_Car_X + i_Car_Speed_Multiplier;
            end 
            else 
            begin
               o_Car_X = i_Car_X - i_Car_Speed_Multiplier;
            end
        end
    endtask

    // Task to handle car boundary condition
    task Check_Car_Boundary;
        input  [9:0]    i_Car_X;
        input           i_Reverse;
        output [9:0]    o_Car_X;  // Modified output to hold the boundary-adjusted position
        begin
            // check where the car is and teleport it to the other side of the screen where a side is reached
            if (i_Car_X >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) 
            begin
                o_Car_X = 0;
            end 
            else if (i_Car_X == 0 && i_Reverse == 1) 
            begin
                o_Car_X = (H_VISIBLE_AREA - TILE_SIZE);
            end 
            else 
            begin
                o_Car_X = i_Car_X;
            end
        end
    endtask

    always @(posedge i_Clk)
    begin
        // Increment difficulty every 3 levels
        case (i_Score)
            1, 2, 3: r_Car_Speed <= C_BASE_CAR_SPEED;
            4, 5, 6: r_Car_Speed <= C_BASE_CAR_SPEED >> 1;
            7, 8, 9: r_Car_Speed <= C_BASE_CAR_SPEED >> 2;
            default: r_Car_Speed <= C_BASE_CAR_SPEED >> 3;
        endcase

        // Update positions if counter reaches car speed threshold
        if (r_Count == r_Car_Speed) 
        begin
            // Update Car 0
            Update_Car_Position(o_Car_X_0, i_Reverse[0], 2, o_Car_X_0);  // Car 0 speed multiplier = 2
            Check_Car_Boundary(o_Car_X_0, i_Reverse[0], o_Car_X_0);      // Adjust for boundary

            // Update Car 1 
            Update_Car_Position(o_Car_X_1, i_Reverse[1], 4, o_Car_X_1);  // Car 1 speed multiplier = 4
            Check_Car_Boundary(o_Car_X_1, i_Reverse[1], o_Car_X_1);      // Adjust for boundary

            // Update Car 2
            Update_Car_Position(o_Car_X_2, i_Reverse[2], 2, o_Car_X_2);  // Car 2 speed multiplier = 2
            Check_Car_Boundary(o_Car_X_2, i_Reverse[2], o_Car_X_2);      // Adjust for boundary

            // Update Car 3
            Update_Car_Position(o_Car_X_3, i_Reverse[3], 1, o_Car_X_3);  // Car 3 speed multiplier = 1
            Check_Car_Boundary(o_Car_X_3, i_Reverse[3], o_Car_X_3);      // Adjust for boundary

            // Update Car 4
            Update_Car_Position(o_Car_X_4, i_Reverse[0], 2, o_Car_X_4);  // Car 4 speed multiplier = 2
            Check_Car_Boundary(o_Car_X_4, i_Reverse[0], o_Car_X_4);  // Adjust for boundary

            // Update Car 5
            Update_Car_Position(o_Car_X_5, i_Reverse[1], 4, o_Car_X_5);  // Car 5 speed multiplier = 4
            Check_Car_Boundary(o_Car_X_5, i_Reverse[1], o_Car_X_5);  // Adjust for boundary

            // Update Car 6
            Update_Car_Position(o_Car_X_6, i_Reverse[2], 2, o_Car_X_6);  // Car 6 speed multiplier = 2
            Check_Car_Boundary(o_Car_X_6, i_Reverse[2], o_Car_X_6);  // Adjust for boundary

            // Update Car 7
            Update_Car_Position(o_Car_X_7, i_Reverse[3], 1, o_Car_X_7);  // Car 7 speed multiplier = 1
            Check_Car_Boundary(o_Car_X_7, i_Reverse[3], o_Car_X_7);  // Adjust for boundary

            r_Count <= 0;  // Reset counter after updating positions
        end 
        else 
        begin
            r_Count <= r_Count + 1;  // Increment the counter
        end
    end
endmodule   