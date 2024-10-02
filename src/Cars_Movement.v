module Cars_Movement(
    input i_Clk,
    
    output reg [9:0] o_Car_X = 10'b0,
);
    reg [19:0] r_Count = 10'b0;

    assign o_Car_X = c_X_BASE_CAR_POSITION;

    always @(posedge i_Clk)
    begin
        if (c_BASE_CAR_SPEED == r_Count)
        begin
            o_Car_X <= o_Car_X + 1;    
            r_Count <= 0;
        end
        else
        begin
            r_Count <= r_Count + 1;
        end
    end



endmodule