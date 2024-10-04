module Obstacles_Movement#(
    parameter c_X_BASE_CAR_POSITION = 0,
    parameter c_X_REVERSE_BASE_CAR_POSITION = 608,
    parameter c_BASE_CAR_SPEED = 781250,
    parameter H_VISIBLE_AREA = 640,
    parameter TILE_SIZE = 32,
    parameter c_NB_CARS = 1
)(
    input       i_Clk,
    input       i_Reverse,

    output reg [9:0] o_Car_X_0 = c_X_BASE_CAR_POSITION, // Car 0 X position
    output reg [9:0] o_Car_X_1 = c_X_BASE_CAR_POSITION + TILE_SIZE + 10, // Car 1 X position
    output reg [9:0] o_Car_X_2 = c_X_BASE_CAR_POSITION + 2 * (TILE_SIZE + 10), // Car 2 X position
    output reg [9:0] o_Car_X_3 = c_X_BASE_CAR_POSITION + 3 * (TILE_SIZE + 10), // Car 3 X position
);

    reg [19:0] r_Count = 0; // Global counter for movement timing

    always @(posedge i_Clk) begin
        if (r_Count == c_BASE_CAR_SPEED) begin
            case (c_NB_CARS)
                3'b001: begin
                    // Car 0
                    if (i_Reverse == 0) begin
                        o_Car_X_0 <= o_Car_X_0 + 1;
                    end else begin
                        o_Car_X_0 <= o_Car_X_0 - 1;
                    end

                    // Boundary condition for Car 0
                    if (o_Car_X_0 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_0 <= 0;
                    end else if (o_Car_X_0 == 0 && i_Reverse == 1) begin
                        o_Car_X_0 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end
                end

                3'b010: begin
                    // Car 0 and Car 1
                    if (i_Reverse == 0) begin
                        o_Car_X_0 <= o_Car_X_0 + 1;
                        o_Car_X_1 <= o_Car_X_1 + 1;
                    end else begin
                        o_Car_X_0 <= o_Car_X_0 - 1;
                        o_Car_X_1 <= o_Car_X_1 - 1;
                    end

                    // Boundary conditions for Car 0 and Car 1
                    if (o_Car_X_0 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_0 <= 0;
                    end else if (o_Car_X_0 == 0 && i_Reverse == 1) begin
                        o_Car_X_0 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end

                    if (o_Car_X_1 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_1 <= 0;
                    end else if (o_Car_X_1 == 0 && i_Reverse == 1) begin
                        o_Car_X_1 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end
                end

                3'b011: begin
                    // Car 0, Car 1, and Car 2
                    if (i_Reverse == 0) begin
                        o_Car_X_0 <= o_Car_X_0 + 1;
                        o_Car_X_1 <= o_Car_X_1 + 1;
                        o_Car_X_2 <= o_Car_X_2 + 1;
                    end else begin
                        o_Car_X_0 <= o_Car_X_0 - 1;
                        o_Car_X_1 <= o_Car_X_1 - 1;
                        o_Car_X_2 <= o_Car_X_2 - 1;
                    end

                    // Boundary conditions for Car 0, Car 1, and Car 2
                    if (o_Car_X_0 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_0 <= 0;
                    end else if (o_Car_X_0 == 0 && i_Reverse == 1) begin
                        o_Car_X_0 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end

                    if (o_Car_X_1 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_1 <= 0;
                    end else if (o_Car_X_1 == 0 && i_Reverse == 1) begin
                        o_Car_X_1 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end

                    if (o_Car_X_2 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_2 <= 0;
                    end else if (o_Car_X_2 == 0 && i_Reverse == 1) begin
                        o_Car_X_2 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end
                end

                3'b100: begin
                    // Car 0, Car 1, and Car 2
                    if (i_Reverse == 0) begin
                        o_Car_X_0 <= o_Car_X_0 + 1;
                        o_Car_X_1 <= o_Car_X_1 + 1;
                        o_Car_X_2 <= o_Car_X_2 + 1;
                        o_Car_X_3 <= o_Car_X_3 + 1;
                    end else begin
                        o_Car_X_0 <= o_Car_X_0 - 1;
                        o_Car_X_1 <= o_Car_X_1 - 1;
                        o_Car_X_2 <= o_Car_X_2 - 1;
                        o_Car_X_3 <= o_Car_X_3 - 1;
                    end

                    // Boundary conditions for Car 0, Car 1, and Car 2
                    if (o_Car_X_0 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_0 <= 0;
                    end else if (o_Car_X_0 == 0 && i_Reverse == 1) begin
                        o_Car_X_0 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end

                    if (o_Car_X_1 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_1 <= 0;
                    end else if (o_Car_X_1 == 0 && i_Reverse == 1) begin
                        o_Car_X_1 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end

                    if (o_Car_X_2 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_2 <= 0;
                    end else if (o_Car_X_2 == 0 && i_Reverse == 1) begin
                        o_Car_X_2 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end

                    if (o_Car_X_3 >= (H_VISIBLE_AREA - TILE_SIZE) && i_Reverse == 0) begin
                        o_Car_X_3 <= 0;
                    end else if (o_Car_X_3 == 0 && i_Reverse == 1) begin
                        o_Car_X_3 <= (H_VISIBLE_AREA - TILE_SIZE);
                    end
                end

                default: begin
                    // Default case: No cars
                end
            endcase

            // Reset the counter after updating positions
            r_Count <= 0;
        end else begin
            r_Count <= r_Count + 1; // Increment the counter
        end
    end
endmodule