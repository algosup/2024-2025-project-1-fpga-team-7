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

    // input  [7:0] i_Color,

    // Frog (Player) left corner position
    input  [9:0] X_Position,
    input  [9:0] Y_Position,

    // Frog (Player) left corner position
    input  [9:0] Car_1X_Position,
    input  [8:0] Car_1Y_Position,
    input  [9:0] Car_2X_Position,
    input  [8:0] Car_2Y_Position,
    input  [9:0] Car_3X_Position,
    input  [8:0] Car_3Y_Position,
    input  [9:0] Car_4X_Position,
    input  [8:0] Car_4Y_Position,

    // VGA Visible Area detector (0 in both when in Visible Area)
    output       o_VGA_HSync,
    output       o_VGA_VSync,

    // VGA Colors
    output       o_VGA_Red_2,
    output       o_VGA_Grn_2,
    output       o_VGA_Blu_2,
);

reg [9:0] h_counter = 0; // Horizontal counter
reg [9:0] v_counter = 0; // Vertical counter

reg       hsync, vsync;
reg [2:0] red, green, blue;

// Screen scanning
always @(posedge i_Clk) 
begin
    if (h_counter == H_TOTAL - 1) 
    begin
        h_counter <= 0;
        if (v_counter == V_TOTAL - 1) 
        begin
            v_counter <= 0;
        end 
        else 
        begin
            v_counter <= v_counter + 1;
        end
    end 
    else 
    begin
        h_counter <= h_counter + 1;
    end
end



always @(posedge i_Clk) 
begin
    // HSYNC signal generation
    if (h_counter >= H_VISIBLE_AREA + H_FRONT_PORCH &&
        h_counter < H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE)
        hsync <= 0;
    else
        hsync <= 1;

    // VSYNC signal generation
    if (v_counter >= V_VISIBLE_AREA + V_FRONT_PORCH &&
        v_counter < V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE)
        vsync <= 0;
    else
        vsync <= 1;
end

task car_display;
    input  [9:0]    Car_X_Position;
    input  [9:0]    Car_Y_Position;
    input  [3:0]    c_NB_CARS;
    input  [7:0]    i_Color;
    begin
        if (((v_counter >= Car_Y_Position) && (v_counter < (Car_Y_Position + TILE_SIZE))) &&
            ((h_counter >= Car_X_Position) && (h_counter < (Car_X_Position + TILE_SIZE))))
        begin
            red <= 3'b111;
            green <= 3'b000;
            blue <= 3'b111;
            // case (i_Color)
            //     0: 
            //     begin
            //         red <= 3'b111;
            //         green <= 3'b000;
            //         blue <= 3'b111;
            //     end
            //     default: 
            //     begin
            //         red <= 3'b111;  
            //         green <= 3'b111;
            //         blue <= 3'b111;
            //     end
            // endcase
        end
    end
endtask

always @(posedge i_Clk) 
begin
    if (h_counter < H_VISIBLE_AREA && v_counter < V_VISIBLE_AREA) 
    begin
        // Print a white square from left corner (x;y)
        if (((v_counter >= Y_Position) && (v_counter < Y_Position + (TILE_SIZE))) &&
                ((h_counter >= X_Position) && (h_counter < X_Position + (TILE_SIZE))))
        begin
            red <= 3'b111;  
            green <= 3'b111;
            blue <= 3'b111;
        end
        else 
        begin
            red <= 3'b000;  
            green <= 3'b000;
            blue <= 3'b000;
        end
        car_display(Car_1X_Position, Car_1Y_Position, i_Color);
        car_display(Car_2X_Position, Car_2Y_Position, i_Color);
        car_display(Car_3X_Position, Car_3Y_Position, i_Color);
        car_display(Car_4X_Position, Car_4Y_Position, i_Color);
    end
end

// return Visible Area boolean and colors
assign o_VGA_HSync = hsync;
assign o_VGA_VSync = vsync;
assign o_VGA_Red_2 = red;
assign o_VGA_Grn_2 = green;
assign o_VGA_Blu_2 = blue;
    
endmodule