`include "Constants.v"

module Frogger_Game (
    input i_Clk,

    input i_Switch_1,
    input i_Switch_2,
    input i_Switch_3,
    input i_Switch_4,

    output o_VGA_HSync,
    output o_VGA_VSync,
    
    // output o_VGA_Red_0,
    // output o_VGA_Red_1,
    output o_VGA_Red_2,

    // output o_VGA_Blu_0,
    // output o_VGA_Blu_1,
    output o_VGA_Blu_2,

    // output o_VGA_Grn_0,
    // output o_VGA_Grn_1,
    output o_VGA_Grn_2,

    output o_Segment1_A,
    output o_Segment1_B,
    output o_Segment1_C,
    output o_Segment1_D,
    output o_Segment1_E,
    output o_Segment1_F,
    output o_Segment1_G,

    output o_Segment2_A,
    output o_Segment2_B,
    output o_Segment2_C,
    output o_Segment2_D,
    output o_Segment2_E,
    output o_Segment2_F,
    output o_Segment2_G,
);

wire w_Switch_1;
wire w_Switch_2;
wire w_Switch_3;
wire w_Switch_4;

wire [9:0] w_ini_Y_Position, w_ini_X_Position, w_Y_Position, w_X_Position;
wire [9:0] w_Car1_X_Position, w_Car1_Y_Position = c_LINE_1_Y;
wire [9:0] w_Car2_X_Position, w_Car2_Y_Position = c_LINE_2_Y;
wire [9:0] w_Car3_X_Position, w_Car3_Y_Position = c_LINE_3_Y;
wire [9:0] w_Car4_X_Position, w_Car4_Y_Position = c_LINE_4_Y;

wire w_Draw_Frog;

wire w_Has_Collided;

wire [6:0] w_Score, w_Score_After_Check;


    Debounce_Filter Debounce_Filter_1_Inst(.i_Clk(i_Clk), .i_Switch(i_Switch_1), .o_Switch(w_Switch_1));

    Debounce_Filter Debounce_Filter_2_Inst(.i_Clk(i_Clk), .i_Switch(i_Switch_2), .o_Switch(w_Switch_2));

    Debounce_Filter Debounce_Filter_3_Inst(.i_Clk(i_Clk), .i_Switch(i_Switch_3), .o_Switch(w_Switch_3));

    Debounce_Filter Debounce_Filter_4_Inst(.i_Clk(i_Clk), .i_Switch(i_Switch_4), .o_Switch(w_Switch_4));

    Frog_Movement Frog_Movement_Inst(
        .i_Clk(i_Clk),
        .i_Has_Collided(w_Has_Collided),
        .i_Frog_Up(w_Switch_1),
        .i_Frog_Lt(w_Switch_2),
        .i_Frog_Rt(w_Switch_3),
        .i_Frog_Dn(w_Switch_4),
        .o_Score(w_Score),
        .o_Draw_Frog(w_Draw_Frog),
        .o_Frog_X(w_X_Position),
        .o_Frog_Y(w_Y_Position),
    );

    Sprite_Display Sprite_Display_Inst(
        .i_Clk(i_Clk),
        .X_Position(w_X_Position),
        .Y_Position(w_Y_Position),
        .Car_1X_Position(w_Car1_X_Position),
        .Car_1Y_Position(w_Car1_Y_Position),
        .Car_2X_Position(w_Car2_X_Position),
        .Car_2Y_Position(w_Car2_Y_Position),
        .Car_3X_Position(w_Car3_X_Position),
        .Car_3Y_Position(w_Car3_Y_Position),
        .Car_4X_Position(w_Car4_X_Position),
        .Car_4Y_Position(w_Car4_Y_Position),
        .o_VGA_HSync(o_VGA_HSync),
        .o_VGA_VSync(o_VGA_VSync),
        .o_VGA_Blu_2(o_VGA_Blu_2),
        .o_VGA_Grn_2(o_VGA_Grn_2),
        .o_VGA_Red_2(o_VGA_Red_2),
    );

    Collisions #(.TILE_SIZE(TILE_SIZE)) Car1(
        .i_Clk(i_Clk),
        .i_Frog_X(w_X_Position),
        .i_Frog_Y(w_Y_Position),
        .i_Car1_X(w_Car1_X_Position),
        .i_Car1_Y(w_Car1_Y_Position),
        .i_Car2_X(w_Car2_X_Position),
        .i_Car2_Y(w_Car2_Y_Position),
        .i_Car3_X(w_Car3_X_Position),
        .i_Car3_Y(w_Car3_Y_Position),
        .i_Car4_X(w_Car4_X_Position),
        .i_Car4_Y(w_Car4_Y_Position),
        .o_Has_Collided(w_Has_Collided),
    );
    
    Obstacles_Movement MovCar1(
        .i_Clk(i_Clk),
        .o_Car_X(w_Car1_X_Position),
    );

    Obstacles_Movement MovCar2(
        .i_Clk(i_Clk),
        .o_Car_X(w_Car2_X_Position),
    );

    Obstacles_Movement MovCar3(
        .i_Clk(i_Clk),
        .o_Car_X(w_Car3_X_Position),
    );

    Obstacles_Movement MovCar4(
        .i_Clk(i_Clk),
        .o_Car_X(w_Car4_X_Position),
    );

    Segment_Display Score_Inst(
        .i_Clk(i_Clk),
        .i_Score(w_Score),
        .o_Segment_A(o_Segment1_A),
        .o_Segment_B(o_Segment1_B),
        .o_Segment_C(o_Segment1_C),
        .o_Segment_D(o_Segment1_D),
        .o_Segment_E(o_Segment1_E),
        .o_Segment_F(o_Segment1_F),
        .o_Segment_G(o_Segment1_G),
        .o_Segment2_A(o_Segment2_A),
        .o_Segment2_B(o_Segment2_B),
        .o_Segment2_C(o_Segment2_C),
        .o_Segment2_D(o_Segment2_D),
        .o_Segment2_E(o_Segment2_E),
        .o_Segment2_F(o_Segment2_F),
        .o_Segment2_G(o_Segment2_G),
    );

endmodule