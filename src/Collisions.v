module Collisions #(
    parameter   TILE_SIZE = 32,
)(
    input  wire i_Clk,

    // Frog left corner
    input  wire [9:0] i_Frog_X, // Assuming 10-bit position values
    input  wire [8:0] i_Frog_Y,

    // Cars left corner
    input  wire [9:0] i_Car1_X,
    input  wire [8:0] i_Car1_Y,
    input  wire [9:0] i_Car2_X,
    input  wire [8:0] i_Car2_Y,
    input  wire [9:0] i_Car3_X,
    input  wire [8:0] i_Car3_Y,
    input  wire [9:0] i_Car4_X,
    input  wire [8:0] i_Car4_Y,

    // Is there a collision or not
    output reg        o_Has_Collided
);

    wire w_Has_Collided1;
    wire w_Has_Collided2;
    wire w_Has_Collided3;
    wire w_Has_Collided4;

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
    Collisions(i_Car1_X, i_Car1_Y, i_Frog_X, i_Frog_Y, w_Has_Collided1);
    Collisions(i_Car2_X, i_Car2_Y, i_Frog_X, i_Frog_Y, w_Has_Collided2);
    Collisions(i_Car3_X, i_Car3_Y, i_Frog_X, i_Frog_Y, w_Has_Collided3);
    Collisions(i_Car4_X, i_Car4_Y, i_Frog_X, i_Frog_Y, w_Has_Collided4);
    if (w_Has_Collided1 || w_Has_Collided2 || w_Has_Collided3 || w_Has_Collided4)
    begin
        o_Has_Collided = 1'b1;
    end
    else
    begin
        o_Has_Collided = 1'b0;
    end
end
endmodule