
`include "Constants.v"

module Collisions #(
    parameter   TILE_SIZE = 32,
)(
    input  wire i_Clk,

    // Frog left corner
    input  wire [9:0] i_Frog_X, // Assuming 10-bit position values
    input  wire [8:0] i_Frog_Y,

    // Cars left corner
    input  wire [9:0] i_Car1_X,
    input  wire [9:0] i_Car2_X,
    input  wire [9:0] i_Car3_X,
    input  wire [9:0] i_Car4_X,
    input  wire [9:0] i_Car5_X,
    input  wire [9:0] i_Car6_X,
    input  wire [9:0] i_Car7_X,
    input  wire [9:0] i_Car8_X,


    // Is there a collision or not
    output reg        o_Has_Collided
);

wire w_Has_Collided1;
wire w_Has_Collided2;
wire w_Has_Collided3;
wire w_Has_Collided4;
wire w_Has_Collided5;
wire w_Has_Collided6;
wire w_Has_Collided7;
wire w_Has_Collided8;
    

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
    Collisions(i_Car5_X, C_LINE_1_Y, i_Frog_X, i_Frog_Y, w_Has_Collided5);
    Collisions(i_Car6_X, C_LINE_2_Y, i_Frog_X, i_Frog_Y, w_Has_Collided6);
    Collisions(i_Car7_X, C_LINE_3_Y, i_Frog_X, i_Frog_Y, w_Has_Collided7);
    Collisions(i_Car8_X, C_LINE_4_Y, i_Frog_X, i_Frog_Y, w_Has_Collided8);
    if (w_Has_Collided1 || w_Has_Collided2 || w_Has_Collided3 || w_Has_Collided4 || w_Has_Collided5 || w_Has_Collided6 || w_Has_Collided7 || w_Has_Collided8)
    begin
        o_Has_Collided = 1'b1;
    end
    else
    begin
        o_Has_Collided = 1'b0;
    end
end
endmodule