module Obstacles_Movement#(
    parameter C_BASE_CAR_SPEED              = 781250,
    parameter H_VISIBLE_AREA                = 640,
    parameter TILE_SIZE                     = 32,
    parameter NUM_BITS                      = 4
)(
    input                       i_Clk,
    input      [NUM_BITS-1:0]   i_Reverse,
    input      [3:0]            i_Score,
    input                       i_Level_Up,
    output reg [9:0]            o_Car_X_0,
    output reg [9:0]            o_Car_X_1     = (TILE_SIZE),
    output reg [9:0]            o_Car_X_2     = 2 * (TILE_SIZE),
    output reg [9:0]            o_Car_X_3     = 3 * (TILE_SIZE),
    output reg [NUM_BITS - 1:0] o_Reverse,
);

    reg [19:0]           r_Count      = 0; // Global counter for movement timing
    reg [19:0]           r_Car_Speed  = C_BASE_CAR_SPEED;

    // Task to update the car's X position
    task Update_Car_Position;
        input  [9:0]    i_Car_X;
        input           i_Reverse;
        input  [2:0]    i_Car_Speed_Multiplier; // Speed multiplier based on the car index
        output [9:0]    o_Car_X;  // Modified output to hold the new position
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

    always @(posedge i_Clk) begin
        case (i_Score)
            1, 2, 3: r_Car_Speed <= C_BASE_CAR_SPEED;
            4, 5, 6: r_Car_Speed <= C_BASE_CAR_SPEED >> 1;
            7, 8, 9: r_Car_Speed <= C_BASE_CAR_SPEED >> 2;
            default: r_Car_Speed <= C_BASE_CAR_SPEED >> 3;
        endcase

        // Update o_Reverse if necessary
        if (o_Reverse == 0 || i_Level_Up == 1) 
        begin
            o_Reverse <= i_Reverse;
        end

        // Update positions if counter reaches car speed threshold
        if (r_Count == r_Car_Speed) 
        begin
            // Update Car 0
            Update_Car_Position(o_Car_X_0, o_Reverse[0], 2, o_Car_X_0);  // Car 0 speed multiplier = 2
            Check_Car_Boundary(o_Car_X_0, o_Reverse[0], o_Car_X_0);  // Adjust for boundary

            // Update Car 1 
            Update_Car_Position(o_Car_X_1, o_Reverse[1], 4, o_Car_X_1);  // Car 1 speed multiplier = 4
            Check_Car_Boundary(o_Car_X_1, o_Reverse[1], o_Car_X_1);  // Adjust for boundary

            // Update Car 2
            Update_Car_Position(o_Car_X_2, o_Reverse[2], 2, o_Car_X_2);  // Car 2 speed multiplier = 2
            Check_Car_Boundary(o_Car_X_2, o_Reverse[2], o_Car_X_2);  // Adjust for boundary

            // Update Car 3
            Update_Car_Position(o_Car_X_3, o_Reverse[3], 1, o_Car_X_3);  // Car 3 speed multiplier = 1
            Check_Car_Boundary(o_Car_X_3, o_Reverse[3], o_Car_X_3);  // Adjust for boundary

            r_Count <= 0;  // Reset counter after updating positions
        end 
        else 
        begin
            r_Count <= r_Count + 1;  // Increment the counter
        end
    end
endmodule   