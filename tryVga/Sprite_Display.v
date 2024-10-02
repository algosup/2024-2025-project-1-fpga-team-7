// This module display the sprites and white squares we use. WIP
module Sprite_Display (
    // Clock
    input        i_Clk,

    // Frog (Player) left corner position
    input  [9:0] X_Position,
    input  [9:0] Y_Position,

    // Frog (Player) left corner position
    input  [9:0] Car_X_Position,
    input  [9:0] Car_Y_Position,

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
wire [9:0] vehicle_X_Position = (Car_X_Position + TILE_SIZE > H_VISIBLE_AREA) ? H_VISIBLE_AREA - TILE_SIZE : Car_X_Position;
wire [9:0] vehicle_Y_Position = (Car_Y_Position + TILE_SIZE > V_VISIBLE_AREA) ? V_VISIBLE_AREA - TILE_SIZE : Car_Y_Position;

reg [9:0]  h_counter          = 0; // Horizontal counter
reg [9:0]  v_counter          = 0; // Vertical counter

reg hsync, vsync;
reg [2:0] red, green, blue;

// First Printing Sprite Test
// reg [15:0] sprite [15:0]; // 16x16 sprite
// initial begin
//     // Define a simple 16x16 square sprite (1 = white, 0 = black)
//     sprite[0]  = 32'b11111111111111111111111111111111;
//     sprite[1]  = 32'b11111111111111111111111111111111;
//     sprite[2]  = 32'b11111111111111111111111111111111;
//     sprite[3]  = 32'b11111111111111111111111111111111;
//     sprite[4]  = 32'b11111111111111111111111111111111;
//     sprite[5]  = 32'b11111111111111111111111111111111;
//     sprite[6]  = 32'b11111111111111111111111111111111;
//     sprite[7]  = 32'b11111111111111111111111111111111;
//     sprite[8]  = 32'b11111111111111111111111111111111;
//     sprite[9]  = 32'b11111111111111111111111111111111;
//     sprite[10] = 32'b11111111111111111111111111111111;
//     sprite[11] = 32'b11111111111111111111111111111111;
//     sprite[12] = 32'b11111111111111111111111111111111;
//     sprite[13] = 32'b11111111111111111111111111111111;
//     sprite[14] = 32'b11111111111111111111111111111111;
//     sprite[15] = 32'b11111111111111111111111111111111;
// end
// parameter SPRITE_X = 100;  // X position of sprite on the screen
// parameter SPRITE_Y = 100;  // Y position of sprite on the screen

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
        else if (((v_counter >= vehicle_Y_Position) && (v_counter < vehicle_Y_Position + (TILE_SIZE))) &&
                ((h_counter >= vehicle_X_Position) && (h_counter < vehicle_X_Position + (TILE_SIZE))))
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