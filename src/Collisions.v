// This module will check if the frog (player) is in the range of obstacles such as cars.
// To do this, we will check if the left corner of the Frog is between the left corner of 
// he car and its right one. We will do the same for the top left and bottom left ones (Y absiss)
module Collisions (
    input  i_Clk,

    // Frog left corner
    input  i_Frog_X,
    input  i_Frog_Y,

    // Cars left corner
    input  i_Car_X,
    input  i_Car_Y,

    // Is there collision or not
    output o_Has_Collided,
);

// In progress
always @(posedge i_Clk)
begin
    if ((i_Frog_X != i_Car_X)) // TODO: condition implementation.
    begin
        o_Has_Collided <= 1'b1;
    end
    else
    begin
        o_Has_Collided <= 1'b0;
    end
end
    
endmodule