module Collisions (
    input  wire i_Clk,

    // Frog left corner
    input  wire [9:0] i_Frog_X, // Assuming 10-bit position values
    input  wire [9:0] i_Frog_Y,

    // Cars left corner
    input  wire [9:0] i_Car_X,
    input  wire [9:0] i_Car_Y,

    // Is there a collision or not
    output reg o_Has_Collided
);

always @(posedge i_Clk) begin
    // Check if the frog's top-left corner is within the car's boundaries
    if ((i_Frog_X >= i_Car_X) && (i_Frog_X < (i_Car_X + TILE_SIZE)) &&
        (i_Frog_Y >= i_Car_Y) && (i_Frog_Y < (i_Car_Y + TILE_SIZE))) 
    begin
        o_Has_Collided <= 1'b1;
    end
    else 
    begin
        o_Has_Collided <= 1'b0;
    end
end
endmodule