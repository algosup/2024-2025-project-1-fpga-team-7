///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// Main file of the game.
// Do the majority of the instantiations and some logic such as game logic and frog direction for display.
//
// I/Os:
// It needs a Clock and a Switch for each direction as inputs.
// As outputs, it needs a horizontal and Vertical Synchronizer, VGA components (3/colors), seven Segments
// and four LEDs.
// 
// Behavior:
// It instantiates all modules with parameters, inputs, outputs, wires, or registers.
// It sets the frog direction (display) according to switches.
// If all the Switches are pressed at the same time, the life counter is initiated to 3 
// and the game state changes to RUNNING, else it stays to IDLE.
// While on RUNNING, decrement life counters by 1 if collisions and set the game state to IDLE when no more lives.
// Switch on/off LEDs according to life's number.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// All global parameters are defined in Constants.v and are included with this line.
`include "Constants.v"

module Frogger_Game (
    // Clock
    input  i_Clk,

    // Physical Switches
    input  i_Switch_1,
    input  i_Switch_2,
    input  i_Switch_3,
    input  i_Switch_4,

    // VGA Synchronizers and Components
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

    // Physical score display
    output o_Segment1_A,
    output o_Segment1_B,
    output o_Segment1_C,
    output o_Segment1_D,
    output o_Segment1_E,
    output o_Segment1_F,
    output o_Segment1_G,

    // Physical LEDs
    output o_LED_1,
    output o_LED_2,
    output o_LED_3,
    output o_LED_4
);

reg                   r_State;                              // Use to store game state

reg  [2:0]            r_Life_Counter            = 3'b111;   // Store lifes

reg  [NUM_BITS - 1:0] r_Reverse                 = 4'b1010;  // Reverse cars 1 and 3

reg  [1:0]            r_Frog_Direction;                     // Store frog direction for display

reg                   r_Has_Collided_tracking;              // Debounce Collision

reg  [3:0]            r_Score;                              // Store the score

wire                  w_Game_Active;                        // return 1 when the game is running

// Switches after debounce
wire                  w_Switch_1;
wire                  w_Switch_2;
wire                  w_Switch_3;
wire                  w_Switch_4;

// return 1 when all 4 switches pressed
wire                  w_All_Switch              = w_Switch_1 && w_Switch_2 && w_Switch_3 && w_Switch_4;

wire [8:0]            w_Y_Position;                         // frog Y position
wire [9:0]            w_X_Position;                         // frog X position

// Obstacles positions
wire [9:0]            w_Car1_X_Position;
wire [9:0]            w_Car2_X_Position;
wire [9:0]            w_Car3_X_Position;
wire [9:0]            w_Car4_X_Position; 

wire                  w_Has_Collided;                       // Collision state

wire                  w_Level_Up;                           // 1 when leveling up

// Cursor X and Y position to display
wire [9:0]            w_V_Counter;
wire [9:0]            w_H_Counter;

wire [8:0]            w_VGA_Pixel;                          // 1 pixel VGA components for the background display

    VGA_Bridge #(.H_VISIBLE_AREA(H_VISIBLE_AREA),
                 .V_VISIBLE_AREA(V_VISIBLE_AREA),
                 .H_TOTAL(H_TOTAL),
                 .V_TOTAL(V_TOTAL),
                 .H_FRONT_PORCH(H_FRONT_PORCH),
                 .H_SYNC_PULSE(H_SYNC_PULSE),
                 .V_FRONT_PORCH(V_FRONT_PORCH),
                 .V_SYNC_PULSE(V_SYNC_PULSE))VGA_Bridge_Inst(
        .i_Clk(i_Clk),
        .o_VGA_HSync(o_VGA_HSync),
        .o_VGA_VSync(o_VGA_VSync),
        .o_V_Counter(w_V_Counter),
        .o_H_Counter(w_H_Counter));

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
        .o_Score(r_Score),
        .o_Level_Up(w_Level_Up),
        .o_Frog_X(w_X_Position),
        .o_Frog_Y(w_Y_Position));

    Background_Display #(.TILE_SIZE(TILE_SIZE),
                         .H_VISIBLE_AREA(H_VISIBLE_AREA),
                         .V_VISIBLE_AREA(V_VISIBLE_AREA)) Background_Display_Inst(
        .i_Clk(i_Clk),
        .i_H_Counter(w_H_Counter),
        .i_V_Counter(w_V_Counter),
        .o_VGA_Pixel(w_VGA_Pixel));

    Sprite_Display #(.TILE_SIZE(TILE_SIZE),
                     .H_VISIBLE_AREA(H_VISIBLE_AREA),
                     .V_VISIBLE_AREA(V_VISIBLE_AREA)) Sprite_Display_Inst(
        .i_Clk(i_Clk),
        .i_Background_Pixel(w_VGA_Pixel),
        .i_Frog_Direction(r_Frog_Direction),
        .i_H_Counter(w_H_Counter),
        .i_V_Counter(w_V_Counter),
        .i_X_Position(w_X_Position),
        .i_Y_Position(w_Y_Position),
        .i_Car_1X_Position(w_Car1_X_Position),
        .i_Car_2X_Position(w_Car2_X_Position),
        .i_Car_3X_Position(w_Car3_X_Position),
        .i_Car_4X_Position(w_Car4_X_Position),
        .i_Reverse(r_Reverse),
        .o_VGA_Blu_1(o_VGA_Blu_1),
        .o_VGA_Blu_2(o_VGA_Blu_2),
        .o_VGA_Blu_3(o_VGA_Blu_3),
        .o_VGA_Grn_1(o_VGA_Grn_1),
        .o_VGA_Grn_2(o_VGA_Grn_2),
        .o_VGA_Grn_3(o_VGA_Grn_3),
        .o_VGA_Red_1(o_VGA_Red_1),
        .o_VGA_Red_2(o_VGA_Red_2),
        .o_VGA_Red_3(o_VGA_Red_3));

    Collisions #(.TILE_SIZE(TILE_SIZE),
                 .C_LINE_1_Y(C_LINE_1_Y),
                 .C_LINE_2_Y(C_LINE_2_Y),
                 .C_LINE_3_Y(C_LINE_3_Y),
                 .C_LINE_4_Y(C_LINE_4_Y)) Collisions_Inst(
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
        .i_Score(r_Score),
        .i_Reverse(r_Reverse),
        .o_Car_X_0(w_Car1_X_Position),
        .o_Car_X_1(w_Car2_X_Position),
        .o_Car_X_2(w_Car3_X_Position),
        .o_Car_X_3(w_Car4_X_Position));

    Seven_Segments_Display Seven_Segments_Display_Inst(
        .i_Clk(i_Clk),
        .i_Score(r_Score),
        .o_Segment_A(o_Segment1_A),
        .o_Segment_B(o_Segment1_B),
        .o_Segment_C(o_Segment1_C),
        .o_Segment_D(o_Segment1_D),
        .o_Segment_E(o_Segment1_E),
        .o_Segment_F(o_Segment1_F),
        .o_Segment_G(o_Segment1_G));

    // Update r_Frog_Direction to help rotating the frog sprite
    always @(posedge i_Clk) 
    begin
        if (w_Switch_1 == 1)
        begin
            r_Frog_Direction <= 0;  // Facing up
        end
        else if (w_Switch_2 == 1)
        begin
            r_Frog_Direction <= 1;  // Facing left
        end
        else if (w_Switch_3 == 1)
        begin
            r_Frog_Direction <= 2;  // Facing right
        end
        else if (w_Switch_4 == 1)
        begin
            r_Frog_Direction <= 3; // Facing down
        end
    end

    //State Machine
    always @(posedge i_Clk) 
    begin
        case (r_State)
            // Before playing or when game over
            IDLE: 
                if (w_All_Switch == 1'b1) 
                begin
                    r_Life_Counter <= 3'b111;       // Reset the number of lives
                    r_State <= RUNNING;           // Only allow the frog to start after all switch has been pressed
                end
            RUNNING: 
                if (w_Has_Collided == 1'b1 && r_Has_Collided_tracking == 1'b0)
                begin
                    // shift right the number of lives
                    r_Life_Counter <= (r_Life_Counter >> 1);

                    if (r_Life_Counter == 1) 
                    begin
                        // Send the player to an Idle state at death
                        r_State <= IDLE;
                    end
                    else
                    begin          // Send the player to an Idle state at death
                        r_State <= RUNNING;
                    end
                end
        endcase
    // Debouncing Collision
    r_Has_Collided_tracking <= w_Has_Collided;

    end

    assign w_Game_Active = (r_State == RUNNING) ? 1'b1 : 1'b0;      // Keep track of whether the game is active or not

    // Display the number of lives
    assign o_LED_1       = 1'b0;
    assign o_LED_2       = r_Life_Counter[2];
    assign o_LED_3       = r_Life_Counter[1];
    assign o_LED_4       = r_Life_Counter[0];
    
endmodule