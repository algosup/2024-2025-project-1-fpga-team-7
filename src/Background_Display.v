///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
//Initiates Block RAM and reads sprites text files.
//
// I/Os:
// This module needs a Clock, and vertical and horizontal Counters as inputs.
// In outputs, a register is 9 bits wide for the VGA components.
// 
// Behavior:
// It instantiates the Memory module for each sprite needed in the background.
// Then it checks the actual position with the horizontal and vertical Counters.
// It returns the VGA components of a pixel and its address regarding the row you have predefined.
// (Here on 15 rows)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Background_Display #(
    parameter TILE_SIZE      = 32,
    parameter H_VISIBLE_AREA = 640,
    parameter V_VISIBLE_AREA = 480,
)(
    input            i_Clk,

    // Vertical and Horizontal Counters
    input      [9:0] i_V_Counter,
    input      [9:0] i_H_Counter,

    // Pixel out
    output reg [8:0] o_VGA_Pixel,
);

localparam ROAD_SPRITE         = "sprites/Road_Sprite.txt";
localparam SIDEWALK_SPRITE     = "sprites/Sidewalk_Sprite.txt";
localparam GRASS_SPRITE        = "sprites/Grass_Sprite.txt";
localparam WATER_LINE_SPRITE   = "sprites/Water_Line_Sprite.txt";
localparam LEFT_FINISH_SPRITE  = "sprites/Left_Finish_Sprite.txt";

reg  [4:0] r_current_tile_row = i_V_Counter[9:5];

// Signals to connect to the Memory modules
reg  [9:0] r_road_sprite_addr;
reg  [9:0] r_sidewalk_sprite_addr;
reg  [9:0] r_grass_sprite_addr;
reg  [9:0] r_water_sprite_addr;
reg  [9:0] r_water_line_sprite_addr;
reg  [9:0] r_left_finish_sprite_addr;
wire [8:0] w_road_pixel_data;
wire [8:0] w_sidewalk_pixel_data;
wire [8:0] w_grass_pixel_data;
wire [8:0] w_water_pixel_data;
wire [8:0] w_water_line_pixel_data;
wire [8:0] w_left_finish_pixel_data;

// Instantiate a part of the block RAM with a text file
Memory #(.INIT_TXT_FILE(ROAD_SPRITE)) road_memory (
    .i_Clk(i_Clk),
    .i_read_addr(r_road_sprite_addr),
    .o_read_data(w_road_pixel_data)  // Output pixel data for frog
);

// Instantiate a part of the block RAM with a text file
Memory #(.INIT_TXT_FILE(SIDEWALK_SPRITE)) sidewalk_memory (
    .i_Clk(i_Clk),
    .i_read_addr(r_sidewalk_sprite_addr),
    .o_read_data(w_sidewalk_pixel_data)  // Output pixel data for frog
);

Memory #(.INIT_TXT_FILE(GRASS_SPRITE)) grass_memory (
    .i_Clk(i_Clk),
    .i_read_addr(r_grass_sprite_addr),
    .o_read_data(w_grass_pixel_data)  // Output pixel data for frog
);

Memory #(.INIT_TXT_FILE(WATER_LINE_SPRITE)) water_memory (
    .i_Clk(i_Clk),
    .i_read_addr(r_water_line_sprite_addr),
    .o_read_data(w_water_line_pixel_data)  // Output pixel data for frog
);

Memory #(.INIT_TXT_FILE(LEFT_FINISH_SPRITE)) left_finish_memory (
    .i_Clk(i_Clk),
    .i_read_addr(r_left_finish_sprite_addr),
    .o_read_data(w_left_finish_pixel_data)  // Output pixel data for frog
);


// Display logic
always @(posedge i_Clk) 
begin
    // Check if in Visible Area
    if (i_H_Counter < H_VISIBLE_AREA && i_V_Counter < V_VISIBLE_AREA)
    begin
        // Returns the pixel of a sprite according to the current row 
        case (r_current_tile_row)
            0:
            begin
                if (i_H_Counter[9:5] == 0)
                begin
                    r_left_finish_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0] + 1;
                    o_VGA_Pixel   <= w_left_finish_pixel_data;
                end
                else 
                begin
                    r_water_line_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                    o_VGA_Pixel   <= w_water_line_pixel_data;
                end
            end
            1,7,13,14:
            begin
                r_grass_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                o_VGA_Pixel   <= w_grass_pixel_data;
            end
            2,6,8,12:
            begin
                r_sidewalk_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                o_VGA_Pixel   <= w_sidewalk_pixel_data;
            end
            3,4,5,9,10,11:
            begin
                r_road_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                o_VGA_Pixel   <= w_road_pixel_data;
            end
            default:
            begin
                o_VGA_Pixel <= 9'd0;
            end
        endcase
    end
end
endmodule