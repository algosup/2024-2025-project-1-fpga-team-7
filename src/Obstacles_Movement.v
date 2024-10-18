module Obstacles_Movement#(
    parameter c_X_BASE_CAR_POSITION = 0,
    parameter c_X_REVERSE_BASE_CAR_POSITION = 608,
    parameter c_BASE_CAR_SPEED = 781250,
    parameter H_VISIBLE_AREA = 640,
    parameter TILE_SIZE = 32,
    parameter c_NB_CARS = 4,
    parameter NUM_BITS = 4,
)(
    input       i_Clk,
    input [NUM_BITS-1:0] i_Reverse,

    input [6:0] i_Score,

    input i_Level_Up,

    output reg [9:0] o_Car_X_0 = c_X_BASE_CAR_POSITION, // Car 0 X position
    output reg [9:0] o_Car_X_1 = c_X_BASE_CAR_POSITION + TILE_SIZE + 10, // Car 1 X position
    output reg [9:0] o_Car_X_2 = c_X_BASE_CAR_POSITION + 2 * (TILE_SIZE + 10), // Car 2 X position
    output reg [9:0] o_Car_X_3 = c_X_BASE_CAR_POSITION + 3 * (TILE_SIZE + 10), // Car 3 X position
);
    reg [NUM_BITS - 1:0] r_Reverse;
    reg [19:0] r_Count = 0; // Global counter for movement timing
    reg [19:0] r_Car_Speed = c_BASE_CAR_SPEED;

    always @(posedge i_Clk) begin
        case (i_Score)
            1, 2, 3: r_Car_Speed <= c_BASE_CAR_SPEED;
            4, 5, 6: r_Car_Speed <= c_BASE_CAR_SPEED >> 1;
            7, 8, 9: r_Car_Speed <= c_BASE_CAR_SPEED >> 2;
            default: r_Car_Speed <= c_BASE_CAR_SPEED >> 3;
        endcase
        if (r_Reverse == 0 || i_Level_Up == 1) begin
            r_Reverse <= i_Reverse;
        end
        if (r_Count == r_Car_Speed) begin
            // Car 0
            if (r_Reverse[0] == 0) begin
                o_Car_X_0 <= o_Car_X_0 + 2;
                end else begin
                    o_Car_X_0 <= o_Car_X_0 - 2;
                end

            // Boundary condition for Car 0
            if (o_Car_X_0 >= (H_VISIBLE_AREA - TILE_SIZE) && r_Reverse[0] == 0) begin
                o_Car_X_0 <= 0;
                end else if (o_Car_X_0 == 0 && r_Reverse[0] == 1) begin
                    o_Car_X_0 <= (H_VISIBLE_AREA - TILE_SIZE);
                end
            
            if (c_NB_CARS > 1) begin

                if (r_Reverse[1] == 0) begin
                o_Car_X_1 <= o_Car_X_1 + 4;
                end else begin
                    o_Car_X_1 <= o_Car_X_1 - 4;
                end

                if (o_Car_X_1 >= (H_VISIBLE_AREA - TILE_SIZE) && r_Reverse[1] == 0) begin
                    o_Car_X_1 <= 0;
                    end else if (o_Car_X_1 == 0 && r_Reverse[1] == 1) begin
                    o_Car_X_1 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end
            end
            
            if (c_NB_CARS > 2) begin

                if (r_Reverse[2] == 0) begin
                o_Car_X_2 <= o_Car_X_2 + 2;
                end else begin
                    o_Car_X_2 <= o_Car_X_2 - 2;
                end

                if (o_Car_X_2 >= (H_VISIBLE_AREA - TILE_SIZE) && r_Reverse[2] == 0) begin
                    o_Car_X_2 <= 0;
                    end else if (o_Car_X_2 == 0 && r_Reverse[2] == 1) begin
                    o_Car_X_2 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end
            end

            if (c_NB_CARS > 3) begin

                if (r_Reverse[3] == 0) begin
                o_Car_X_3 <= o_Car_X_3 + 1;
                end else begin
                    o_Car_X_3 <= o_Car_X_3 - 1;
                end

                if (o_Car_X_3 >= (H_VISIBLE_AREA - TILE_SIZE) && r_Reverse[3] == 0) begin
                    o_Car_X_3 <= 0;
                    end else if (o_Car_X_3 == 0 && r_Reverse[3] == 1) begin
                    o_Car_X_3 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end
            end

            // Reset the counter after updating positions
            r_Count <= 0;
        end else begin
            r_Count <= r_Count + 1; // Increment the counter
        end
    end
endmodule