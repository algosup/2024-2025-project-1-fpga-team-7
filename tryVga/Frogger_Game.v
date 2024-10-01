`include "Constants.v"

module Frogger_Game (
    input i_Clk,

    input i_Switch_1,
    input i_Switch_2,
    input i_Switch_3,
    input i_Switch_4,

    output o_VGA_HSync,
    output o_VGA_VSync,
    
    output o_VGA_Red_0,
    output o_VGA_Red_1,
    output o_VGA_Red_2,

    output o_VGA_Blu_0,
    output o_VGA_Blu_1,
    output o_VGA_Blu_2,

    output o_VGA_Grn_0,
    output o_VGA_Grn_1,
    output o_VGA_Grn_2,
);

wire w_Switch_1;
wire w_Switch_2;
wire w_Switch_3;
wire w_Switch_4;

wire [9:0] w_ini_Y_Position, w_ini_X_Position, w_Y_Position, w_X_Position;
wire w_Draw_Frog;


reg [6:0] r_Score = 7'd0;


    Debounce_Switch Debounce_Switch_1_Inst(.i_Clk(i_Clk), .i_Switch(i_Switch_1), .o_Switch(w_Switch_1));

    Debounce_Switch Debounce_Switch_2_Inst(.i_Clk(i_Clk), .i_Switch(i_Switch_2), .o_Switch(w_Switch_2));

    Debounce_Switch Debounce_Switch_3_Inst(.i_Clk(i_Clk), .i_Switch(i_Switch_3), .o_Switch(w_Switch_3));

    Debounce_Switch Debounce_Switch_4_Inst(.i_Clk(i_Clk), .i_Switch(i_Switch_4), .o_Switch(w_Switch_4));

    Frog_Movement Frog_Movement_Inst(
        .i_Clk(i_Clk),
        .i_Frog_Up(w_Switch_1),
        .i_Frog_Lt(w_Switch_2),
        .i_Frog_Rt(w_Switch_3),
        .i_Frog_Dn(w_Switch_4),
        .o_Draw_Frog(w_Draw_Frog),
        .o_Frog_X(w_X_Position),
        .o_Frog_Y(w_Y_Position),
    );


    Sprite_Display Sprite_Display_Inst(
        .i_Clk(i_Clk),
        .X_Position(w_X_Position),
        .Y_Position(w_Y_Position),
        .o_VGA_HSync(o_VGA_HSync),
        .o_VGA_VSync(o_VGA_VSync),
        .o_VGA_Blu_2(o_VGA_Blu_2),
        .o_VGA_Grn_2(o_VGA_Grn_2),
        .o_VGA_Red_2(o_VGA_Red_2),
    );

endmodule