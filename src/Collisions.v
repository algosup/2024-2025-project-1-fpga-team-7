///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// This module checks the collisions between cars and the frog.
//
// I/Os:
// It uses a Clock, wires for frog X and Y position, and one for each car X position as inputs.
// As outputs, it uses only a register for collisions.
// 
// Behavior:
// It checks if the frog's top left and top right corners collide with the top of the car or its left side.
// It returns 1 when collisions and 0 when not. 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Collisions #(
    parameter TILE_SIZE  = 32,
    parameter C_LINE_1_Y = 128, // line car 1
    parameter C_LINE_2_Y = 160, // line car 2
    parameter C_LINE_3_Y = 192, // line car 3
    parameter C_LINE_4_Y = 288, // line car 4
    parameter C_LINE_5_Y = 320, // line car 4
)(
    // Clock
    input  wire       i_Clk,

    // Frog left corner
    input  wire [9:0] i_Frog_X, // Assuming 10-bit position values
    input  wire [8:0] i_Frog_Y,

    // Cars left corner
    input  wire [9:0] i_Car1_X,
    input  wire [9:0] i_Car2_X,
    input  wire [9:0] i_Car3_X,
    input  wire [9:0] i_Car4_X,
    input  wire [9:0] i_Car5_X,

    // Is there a collision or not
    output reg        o_Has_Collided
);

    wire w_Has_Collided1;
    wire w_Has_Collided2;
    wire w_Has_Collided3;
    wire w_Has_Collided4;
    wire w_Has_Collided5;
    wire w_Has_Collided6;
    

    // Looks if collisions between frog and a car.
    task Collisions;
        input  [9:0]    i_Car_X;
        input  [8:0]    i_Car_Y;
        input  [9:0]    i_Frog_X;
        input  [8:0]    i_Frog_Y;
        output          o_Has_Collided;
        begin
            if ((((i_Frog_X >= i_Car_X) && (i_Frog_X < (i_Car_X + TILE_SIZE))) ||
               (((i_Frog_X + TILE_SIZE) >= i_Car_X) && ((i_Frog_X + TILE_SIZE) < (i_Car_X + TILE_SIZE)))) &&
               ((i_Frog_Y >= i_Car_Y) && (i_Frog_Y < (i_Car_Y + TILE_SIZE))))
            begin
                o_Has_Collided = 1'b1;
            end
            else
            begin
                o_Has_Collided = 1'b0;
            end
        end
    endtask
    
    always @(posedge i_Clk) 
    begin
        // Check if the frog's top-left corner is within the car's boundaries
        Collisions(i_Car1_X, C_LINE_1_Y, i_Frog_X, i_Frog_Y, w_Has_Collided1); // C_LINE_1_Y is the Y position of the first car
        Collisions(i_Car2_X, C_LINE_2_Y, i_Frog_X, i_Frog_Y, w_Has_Collided2);
        Collisions(i_Car3_X, C_LINE_3_Y, i_Frog_X, i_Frog_Y, w_Has_Collided3);
        Collisions(i_Car4_X, C_LINE_4_Y, i_Frog_X, i_Frog_Y, w_Has_Collided4);
        Collisions(i_Car5_X, C_LINE_5_Y, i_Frog_X, i_Frog_Y, w_Has_Collided5);
        Collisions(i_Car2_X, C_LINE_6_Y, i_Frog_X, i_Frog_Y, w_Has_Collided6);
        if (w_Has_Collided1 || w_Has_Collided2 || w_Has_Collided3 || w_Has_Collided4 || w_Has_Collided5 || w_Has_Collided6)
        begin
            o_Has_Collided = 1'b1;
        end
        else
        begin
            o_Has_Collided = 1'b0;
        end
    end
endmodule