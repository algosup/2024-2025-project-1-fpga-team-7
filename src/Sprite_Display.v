// This module display the sprites and white squares we use. WIP
module Sprite_Display (
    // Clock
    input        i_Clk,

    // Frog (Player) left corner position
    input  [9:0] X_Position,
    input  [9:0] Y_Position,

    // Frog (Player) left corner position
    input  [9:0] Car_1X_Position,
    input  [9:0] Car_1Y_Position,
    input  [9:0] Car_2X_Position,
    input  [9:0] Car_2Y_Position,
    input  [9:0] Car_3X_Position,
    input  [9:0] Car_3Y_Position,
    input  [9:0] Car_4X_Position,
    input  [9:0] Car_4Y_Position,

    // VGA Visible Area detector (0 in both when in Visible Area)
    output       o_VGA_HSync,
    output       o_VGA_VSync,

    // VGA Colors
    output       o_VGA_Red_2,
    output       o_VGA_Grn_2,
    output       o_VGA_Blu_2,
);

// Clamp X_Position and Y_Position so they don't go beyond the screen edges
wire [9:0] clamped_X_Position = (X_Position + TILE_SIZE > H_VISIBLE_AREA) ? H_VISIBLE_AREA - TILE_SIZE : X_Position;
wire [9:0] clamped_Y_Position = (Y_Position + TILE_SIZE > V_VISIBLE_AREA) ? V_VISIBLE_AREA - TILE_SIZE : Y_Position;

// Clamp Car_X_Position and Car_Y_Position so they don't go beyond the screen edges
wire [9:0] vehicle_1X_Position = (Car_1X_Position + TILE_SIZE > H_VISIBLE_AREA) ? H_VISIBLE_AREA - TILE_SIZE : Car_1X_Position;
wire [9:0] vehicle_1Y_Position = (Car_1Y_Position + TILE_SIZE > V_VISIBLE_AREA) ? V_VISIBLE_AREA - TILE_SIZE : Car_1Y_Position;
wire [9:0] vehicle_2X_Position = (Car_2X_Position + TILE_SIZE > H_VISIBLE_AREA) ? H_VISIBLE_AREA - TILE_SIZE : Car_2X_Position;
wire [9:0] vehicle_2Y_Position = (Car_2Y_Position + TILE_SIZE > V_VISIBLE_AREA) ? V_VISIBLE_AREA - TILE_SIZE : Car_2Y_Position;
wire [9:0] vehicle_3X_Position = (Car_3X_Position + TILE_SIZE > H_VISIBLE_AREA) ? H_VISIBLE_AREA - TILE_SIZE : Car_3X_Position;
wire [9:0] vehicle_3Y_Position = (Car_3Y_Position + TILE_SIZE > V_VISIBLE_AREA) ? V_VISIBLE_AREA - TILE_SIZE : Car_3Y_Position;
wire [9:0] vehicle_4X_Position = (Car_4X_Position + TILE_SIZE > H_VISIBLE_AREA) ? H_VISIBLE_AREA - TILE_SIZE : Car_4X_Position;
wire [9:0] vehicle_4Y_Position = (Car_4Y_Position + TILE_SIZE > V_VISIBLE_AREA) ? V_VISIBLE_AREA - TILE_SIZE : Car_4Y_Position;

reg [9:0]  h_counter          = 0; // Horizontal counter
reg [9:0]  v_counter          = 0; // Vertical counter

reg hsync, vsync;
reg [2:0] red, green, blue;

// Screen scanning
always @(posedge i_Clk) begin
    if (h_counter == H_TOTAL - 1) begin
        h_counter <= 0;
        if (v_counter == V_TOTAL - 1) begin
            v_counter <= 0;
        end else begin
            v_counter <= v_counter + 1;
        end
    end else begin
        h_counter <= h_counter + 1;
    end
end



always @(posedge i_Clk) begin
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


always @(posedge i_Clk) begin
    if (h_counter < H_VISIBLE_AREA && v_counter < V_VISIBLE_AREA) 
    begin
        // Print a white square from left corner (x;y)
        if (((v_counter >= clamped_Y_Position) && (v_counter < clamped_Y_Position + (TILE_SIZE))) &&
                ((h_counter >= clamped_X_Position) && (h_counter < clamped_X_Position + (TILE_SIZE))))
        begin
            red <= 3'b111;  
            green <= 3'b111;
            blue <= 3'b111;
        end 
        else if (((v_counter >= vehicle_1Y_Position) && (v_counter < (vehicle_1Y_Position + TILE_SIZE))) &&
                ((h_counter >= vehicle_1X_Position) && (h_counter < (vehicle_1X_Position + TILE_SIZE))))
        begin
            red <= 3'b111;  
            green <= 3'b000;
            blue <= 3'b111;
        end 
        else if (((v_counter >= vehicle_2Y_Position) && (v_counter < (vehicle_2Y_Position + TILE_SIZE))) &&
                ((h_counter >= vehicle_2X_Position) && (h_counter < (vehicle_2X_Position + TILE_SIZE))))
        begin
            red <= 3'b111;  
            green <= 3'b000;
            blue <= 3'b111;
        end 
        else if (((v_counter >= vehicle_3Y_Position) && (v_counter < (vehicle_3Y_Position + TILE_SIZE))) &&
                ((h_counter >= vehicle_3X_Position) && (h_counter < (vehicle_3X_Position + TILE_SIZE))))
        begin
            red <= 3'b111;  
            green <= 3'b000;
            blue <= 3'b111;
        end 
        else if (((v_counter >= vehicle_4Y_Position) && (v_counter < (vehicle_4Y_Position + TILE_SIZE))) &&
                ((h_counter >= vehicle_4X_Position) && (h_counter < (vehicle_4X_Position + TILE_SIZE))))
        begin
            red <= 3'b111;  
            green <= 3'b000;
            blue <= 3'b111;
        end 
        else 
        begin
            red <= 3'b000;  
            green <= 3'b000;
            blue <= 3'b000;
        end
    end 
    else 
    begin
        red <= 3'b000;  
        green <= 3'b000;
        blue <= 3'b000;
    end
end

// return Visible Area boolean and colors
assign o_VGA_HSync = hsync;
assign o_VGA_VSync = vsync;
assign o_VGA_Red_2 = red;
assign o_VGA_Grn_2 = green;
assign o_VGA_Blu_2 = blue;
    
endmodule