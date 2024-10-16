// This module display the sprites and white squares we use. WIP
module Sprite_Display #(
    parameter TILE_SIZE      = 32,
    parameter H_VISIBLE_AREA = 640,
    parameter V_VISIBLE_AREA = 480,
    parameter H_TOTAL        = 800,
    parameter V_TOTAL        = 525,
    parameter H_FRONT_PORCH  = 16,
    parameter H_SYNC_PULSE   = 96,
    parameter V_FRONT_PORCH  = 10,
    parameter V_SYNC_PULSE   = 2
    )(
    // Clock
    input        i_Clk,

    input  [7:0] i_Color,

    // Frog (Player) left corner position
    input  [9:0] i_X_Position,
    input  [8:0] i_Y_Position,

    // Frog (Player) left corner position
    input  [9:0] i_Car_1X_Position,
    input  [8:0] i_Car_1Y_Position,
    input  [9:0] i_Car_2X_Position,
    input  [8:0] i_Car_2Y_Position,
    input  [9:0] i_Car_3X_Position,
    input  [8:0] i_Car_3Y_Position,
    input  [9:0] i_Car_4X_Position,
    input  [8:0] i_Car_4Y_Position,

    // VGA Visible Area detector (0 in both when in Visible Area)
    output       o_VGA_HSync,
    output       o_VGA_VSync,

    // VGA Colors
    output       o_VGA_Red_2,
    output       o_VGA_Grn_2,
    output       o_VGA_Blu_2
);

reg [9:0] r_h_counter = 0; // Horizontal counter
reg [9:0] r_v_counter = 0; // Vertical counter

reg       r_hsync, r_vsync;
reg [2:0] r_red, r_green, r_blue;

// Screen scanning
always @(posedge i_Clk) 
begin
    if (r_h_counter == H_TOTAL - 1) 
    begin
        r_h_counter <= 0;
        if (r_v_counter == V_TOTAL - 1) 
        begin
            r_v_counter <= 0;
        end 
        else 
        begin
            r_v_counter <= r_v_counter + 1;
        end
    end 
    else 
    begin
        r_h_counter <= r_h_counter + 1;
    end
end



always @(posedge i_Clk) 
begin
    // HSYNC signal generation
    if (r_h_counter >= H_VISIBLE_AREA + H_FRONT_PORCH &&
        r_h_counter < H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE)
        r_hsync <= 0;
    else
        r_hsync <= 1;

    // VSYNC signal generation
    if (r_v_counter >= V_VISIBLE_AREA + V_FRONT_PORCH &&
        r_v_counter < V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE)
        r_vsync <= 0;
    else
        r_vsync <= 1;
end

task Car_Display;
    input  [9:0]    i_Car_X_Position;
    input  [9:0]    i_Car_Y_Position;
    input  [7:0]    i_Color;
    begin
        if (((r_v_counter >= i_Car_Y_Position) && (r_v_counter < (i_Car_Y_Position + TILE_SIZE))) &&
            ((r_h_counter >= i_Car_X_Position) && (r_h_counter < (i_Car_X_Position + TILE_SIZE))))
        begin
            r_red <= 3'b111;
            r_green <= 3'b000;
            r_blue <= 3'b111;
            // case (i_Color)
            //     0: 
            //     begin
            //         r_red <= 3'b111;
            //         r_green <= 3'b000;
            //         r_blue <= 3'b111;
            //     end
            //     default: 
            //     begin
            //         r_red <= 3'b111;  
            //         r_green <= 3'b111;
            //         r_blue <= 3'b111;
            //     end
            // endcase
        end
    end
endtask

always @(posedge i_Clk) 
begin
    if (r_h_counter < H_VISIBLE_AREA && r_v_counter < V_VISIBLE_AREA) 
    begin
        // Print a white square from left corner (x;y)
        if (((r_v_counter >= i_Y_Position) && (r_v_counter < i_Y_Position + (TILE_SIZE))) &&
                ((r_h_counter >= i_X_Position) && (r_h_counter < i_X_Position + (TILE_SIZE))))
        begin
            r_red <= 3'b111;  
            r_green <= 3'b111;
            r_blue <= 3'b111;
        end
        else 
        begin
            r_red <= 3'b000;  
            r_green <= 3'b000;
            r_blue <= 3'b000;
        end
        Car_Display(i_Car_1X_Position, i_Car_1Y_Position, i_Color);
        Car_Display(i_Car_2X_Position, i_Car_2Y_Position, i_Color);
        Car_Display(i_Car_3X_Position, i_Car_3Y_Position, i_Color);
        Car_Display(i_Car_4X_Position, i_Car_4Y_Position, i_Color);
    end
end

// return Visible Area boolean and colors
assign o_VGA_HSync = r_hsync;
assign o_VGA_VSync = r_vsync;
assign o_VGA_Red_2 = r_red;
assign o_VGA_Grn_2 = r_green;
assign o_VGA_Blu_2 = r_blue;
    
endmodule