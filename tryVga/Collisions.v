module Obstacle (
    input i_Clk,
    input i_Frog_X,
    input i_Frog_Y,
    input i_Car_X,
    input i_Car_Y,
    output o_Has_Collided,
);

// Do the condition
always @(posedge i_Clk)
begin
    if ((i_Frog_X != i_Car_X)) 
    begin
        o_Has_Collided <= 1'b1;
    end
    else
    begin
        o_Has_Collided <= 1'b0;
    end
end
    
endmodule