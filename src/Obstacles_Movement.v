module Obstacles_Movement(
    input i_Clk,

    output reg [9:0] o_Car_X = c_X_BASE_CAR_POSITION,
);
    reg [19:0] r_Count = 10'b0;

    always @(posedge i_Clk)
    begin
        if (r_Count == c_BASE_CAR_SPEED)
        begin
            o_Car_X <= o_Car_X + 1;
            r_Count <= 0;
        end
        else
        begin
            r_Count <= r_Count + 1;
        end

        if (o_Car_X == (H_VISIBLE_AREA - 32))
        begin
            o_Car_X <= 0;
        end
    end
endmodule