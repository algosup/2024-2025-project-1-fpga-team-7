`include "Constants.v"

module Frogger_Game (
    input  i_Clk,

    input  i_Switch_1,
    input  i_Switch_2,
    input  i_Switch_3,
    input  i_Switch_4,

    input i_write_en,
    input i_read_en,
    input [4:0] i_write_addr,
    input [4:0] i_read_addr,
    input [7:0] i_write_data,

    output o_VGA_HSync,
    output o_VGA_VSync,
    
    output o_VGA_Red_1,
    output o_VGA_Red_2,
    output o_VGA_Red_3,
    output o_VGA_Blu_1,
    output o_VGA_Blu_2,
    output o_VGA_Blu_3,
    output o_VGA_Grn_1,
    output o_VGA_Grn_2,
    output o_VGA_Grn_3,

    output o_Segment1_A,
    output o_Segment1_B,
    output o_Segment1_C,
    output o_Segment1_D,
    output o_Segment1_E,
    output o_Segment1_F,
    output o_Segment1_G,
);

reg                   r_State;

wire                  w_Game_Active;

wire                  w_Switch_1;
wire                  w_Switch_2;
wire                  w_Switch_3;
wire                  w_Switch_4;

wire                  w_All_Switch       = w_Switch_1 && w_Switch_2 && w_Switch_3 && w_Switch_4;

wire [8:0]            w_Y_Position; 
wire [9:0]            w_X_Position;

wire [9:0]            w_Car1_X_Position;
wire [9:0]            w_Car2_X_Position;
wire [9:0]            w_Car3_X_Position;
wire [9:0]            w_Car4_X_Position; 

wire                  w_Has_Collided;

wire [NUM_BITS - 1:0] w_LFSR_Data;
wire                  w_LFSR_Done;

wire                  w_Level_Up;

wire [3:0]            w_Score;
// wire [7:0] w_test_data = o_read_data;


    LFSR #(.NUM_BITS(NUM_BITS)) LFSR_Inst(
        .i_Clk(i_Clk),
        .i_Enable(1'b1),
        .o_LFSR_Data(w_LFSR_Data),
        .o_LFSR_Done(w_LFSR_Done));

    Debounce_Filter #(.C_DEBOUNCE_LIMIT(C_DEBOUNCE_LIMIT)) Debounce_Filter_Inst_1(
        .i_Clk(i_Clk), 
        .i_Switch(i_Switch_1), 
        .o_Switch(w_Switch_1));

    Debounce_Filter #(.C_DEBOUNCE_LIMIT(C_DEBOUNCE_LIMIT)) Debounce_Filter_Inst_2(
        .i_Clk(i_Clk), 
        .i_Switch(i_Switch_2), 
        .o_Switch(w_Switch_2));

    Debounce_Filter #(.C_DEBOUNCE_LIMIT(C_DEBOUNCE_LIMIT)) Debounce_Filter_Inst_3(
        .i_Clk(i_Clk), 
        .i_Switch(i_Switch_3), 
        .o_Switch(w_Switch_3));

    Debounce_Filter #(.C_DEBOUNCE_LIMIT(C_DEBOUNCE_LIMIT)) Debounce_Filter_Inst_4(
        .i_Clk(i_Clk), 
        .i_Switch(i_Switch_4), 
        .o_Switch(w_Switch_4));

    Character_Control #(.C_SCORE_INI(C_SCORE_INI),
                        .C_X_BASE_POSITION(C_X_BASE_POSITION),
                        .C_Y_BASE_POSITION(C_Y_BASE_POSITION),
                        .COUNT_LIMIT(COUNT_LIMIT),
                        .TILE_SIZE(TILE_SIZE),
                        .V_VISIBLE_AREA(V_VISIBLE_AREA),
                        .H_VISIBLE_AREA(H_VISIBLE_AREA)) Character_Control_Inst(
        .i_Clk(i_Clk),
        .i_Has_Collided(w_Has_Collided),
        .i_Frog_Up(w_Switch_1),
        .i_Frog_Lt(w_Switch_2),
        .i_Frog_Rt(w_Switch_3),
        .i_Frog_Dn(w_Switch_4),
        .i_Game_Active(w_Game_Active),
        .o_Score(w_Score),
        .o_Level_Up(w_Level_Up),
        .o_Frog_X(w_X_Position),
        .o_Frog_Y(w_Y_Position));

    Sprite_Display #(.TILE_SIZE(TILE_SIZE),
                     .H_VISIBLE_AREA(H_VISIBLE_AREA),
                     .V_VISIBLE_AREA(V_VISIBLE_AREA),
                     .H_TOTAL(H_TOTAL),
                     .V_TOTAL(V_TOTAL),
                     .H_FRONT_PORCH(H_FRONT_PORCH),
                     .H_SYNC_PULSE(H_SYNC_PULSE),
                     .V_FRONT_PORCH(V_FRONT_PORCH),
                     .V_SYNC_PULSE(V_SYNC_PULSE)) Sprite_Display_Inst(
        .i_Clk(i_Clk),
        // .i_Color(o_read_data),
        .i_X_Position(w_X_Position),
        .i_Y_Position(w_Y_Position),
        .i_Car_1X_Position(w_Car1_X_Position),
        .i_Car_2X_Position(w_Car2_X_Position),
        .i_Car_3X_Position(w_Car3_X_Position),
        .i_Car_4X_Position(w_Car4_X_Position),
        .o_VGA_HSync(o_VGA_HSync),
        .o_VGA_VSync(o_VGA_VSync),
        .o_VGA_Blu_1(o_VGA_Blu_1),
        .o_VGA_Blu_2(o_VGA_Blu_2),
        .o_VGA_Blu_3(o_VGA_Blu_3),
        .o_VGA_Grn_1(o_VGA_Grn_1),
        .o_VGA_Grn_2(o_VGA_Grn_2),
        .o_VGA_Grn_3(o_VGA_Grn_3),
        .o_VGA_Red_1(o_VGA_Red_1),
        .o_VGA_Red_2(o_VGA_Red_2),
        .o_VGA_Red_3(o_VGA_Red_3)
        
        );

    Collisions #(.TILE_SIZE(TILE_SIZE))Collisions_Inst(
        .i_Clk(i_Clk),
        .i_Frog_X(w_X_Position),
        .i_Frog_Y(w_Y_Position),
        .i_Car1_X(w_Car1_X_Position),
        .i_Car2_X(w_Car2_X_Position),
        .i_Car3_X(w_Car3_X_Position),
        .i_Car4_X(w_Car4_X_Position),
        .o_Has_Collided(w_Has_Collided));
    
    Obstacles_Movement #(.C_BASE_CAR_SPEED(C_BASE_CAR_SPEED),
                         .H_VISIBLE_AREA(H_VISIBLE_AREA),
                         .TILE_SIZE(TILE_SIZE),
                         .NUM_BITS(NUM_BITS)) Obstacles_Movement_Inst(
        .i_Clk(i_Clk),
        .i_Level_Up(w_Level_Up),
        .i_Score(w_Score),
        .i_Reverse(w_LFSR_Data),
        .o_Car_X_0(w_Car1_X_Position),
        .o_Car_X_1(w_Car2_X_Position),
        .o_Car_X_2(w_Car3_X_Position),
        .o_Car_X_3(w_Car4_X_Position));

    Seven_Segments_Display Seven_Segments_Display_Inst(
        .i_Clk(i_Clk),
        .i_Score(w_Score),
        .o_Segment_A(o_Segment1_A),
        .o_Segment_B(o_Segment1_B),
        .o_Segment_C(o_Segment1_C),
        .o_Segment_D(o_Segment1_D),
        .o_Segment_E(o_Segment1_E),
        .o_Segment_F(o_Segment1_F),
        .o_Segment_G(o_Segment1_G));

    //State Machine
    always @(posedge i_Clk)
    case (r_State)
        IDLE: if (w_All_Switch == 1'b1) 
              begin
                  r_State <= RUNNING;           // Only allow the frog to start after all switch has been pressed
              end
        RUNNING: if (w_Has_Collided == 1'b1)
                 begin
                     r_State <= IDLE;           // Send the player to an Idle state at death
                 end
        default: r_State <= IDLE;
    endcase

    assign w_Game_Active = (r_State == RUNNING) ? 1'b1 : 1'b0;      // Keep track of whether the game is active or not
    
endmodule