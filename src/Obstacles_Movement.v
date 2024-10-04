module Obstacles_Movement#(
    parameter c_X_BASE_CAR_POSITION = 0,
    parameter c_X_REVERSE_BASE_CAR_POSITION = 608,
    parameter c_BASE_CAR_SPEED = 781250,
    parameter H_VISIBLE_AREA = 640,
    parameter TILE_SIZE = 32
)(
    input       i_Clk,
    input       i_Reverse,
    input [2:0] i_Nb_Cars,

    output reg [9:0] o_Car_X = c_X_BASE_CAR_POSITION,
);
    reg [19:0] r_Count = 10'b0;

    always @(posedge i_Clk)
    begin
        if (r_Count == c_BASE_CAR_SPEED)
        begin
            case (i_Nb_Cars)
                1: if (i_Reverse == 0) 
                   begin
                      o_Car_X <= o_Car_X + 1;
                      r_Count <= 0;    
                   end
                   else
                   begin
                      o_Car_X <= o_Car_X - 1;
                      r_Count <= 0;
                   end
                default:
                    i_Nb_Cars <= i_Nb_Cars; 
            endcase
        end
        else
        begin
            r_Count <= r_Count + 1;
        end

        if (o_Car_X == (H_VISIBLE_AREA - 32) && i_Reverse == 0)
        begin
            o_Car_X <= 0;
        end
        else if (o_Car_X == 0 && i_Reverse == 1)
        begin
            o_Car_X <= (H_VISIBLE_AREA - 32);
        end
    end
endmodule