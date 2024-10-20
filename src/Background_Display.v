module Background_Display #(
    parameter TILE_SIZE      = 32,
    parameter H_VISIBLE_AREA = 640,
    parameter V_VISIBLE_AREA = 480,
)(
    input            i_Clk,

    input      [9:0] i_V_Counter,
    input      [9:0] i_H_Counter,

    // Pixel out
    output reg [8:0] o_VGA_Pixel,
);

localparam ROAD_SPRITE         = "Road_Sprite.txt";
localparam SIDEWALK_SPRITE     = "Sidewalk_Sprite.txt";
localparam GRASS_FINISH_SPRITE = "Grass_Finish_Sprite.txt";
localparam GRASS_SPRITE        = "Grass_Sprite.txt";
localparam WATER_SPRITE        = "Water_Sprite.txt";

reg  [4:0] r_current_tile_row = i_V_Counter[9:5];

// Signals to connect to the Memory modules
reg  [9:0] road_sprite_addr;
reg  [9:0] sidewalk_sprite_addr;
reg  [9:0] grass_finish_sprite_addr;
reg  [9:0] grass_sprite_addr;
reg  [9:0] water_sprite_addr;
wire [8:0] road_pixel_data;
wire [8:0] sidewalk_pixel_data;
wire [8:0] grass_finish_pixel_data;
wire [8:0] grass_pixel_data;
wire [8:0] water_pixel_data;

Memory #(.INIT_TXT_FILE(ROAD_SPRITE)) road_memory (
    .i_Clk(i_Clk),
    .i_read_addr(road_sprite_addr),
    .o_read_data(road_pixel_data)  // Output pixel data for frog
);

Memory #(.INIT_TXT_FILE(SIDEWALK_SPRITE)) sidewalk_memory (
    .i_Clk(i_Clk),
    .i_read_addr(sidewalk_sprite_addr),
    .o_read_data(sidewalk_pixel_data)  // Output pixel data for frog
);

Memory #(.INIT_TXT_FILE(GRASS_FINISH_SPRITE)) grass_finish_memory (
    .i_Clk(i_Clk),
    .i_read_addr(grass_finish_sprite_addr),
    .o_read_data(grass_finish_pixel_data)  // Output pixel data for frog
);

Memory #(.INIT_TXT_FILE(GRASS_SPRITE)) grass_memory (
    .i_Clk(i_Clk),
    .i_read_addr(grass_sprite_addr),
    .o_read_data(grass_pixel_data)  // Output pixel data for frog
);

Memory #(.INIT_TXT_FILE(WATER_SPRITE)) water_memory (
    .i_Clk(i_Clk),
    .i_read_addr(water_sprite_addr),
    .o_read_data(water_pixel_data)  // Output pixel data for frog
);

    // Display logic
always @(posedge i_Clk) 
begin
    if (i_H_Counter < H_VISIBLE_AREA && i_V_Counter < V_VISIBLE_AREA)
    begin
        case (r_current_tile_row)
            0:
            begin
                water_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                o_VGA_Pixel   <= water_pixel_data;
            end
            1,12,13,14:
            begin
                grass_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                o_VGA_Pixel   <= grass_pixel_data;
            end
            2:
            begin
                grass_finish_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                o_VGA_Pixel   <= grass_finish_pixel_data;
            end
            3,5,7,9,11:
            begin
                sidewalk_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                o_VGA_Pixel   <= sidewalk_pixel_data;
            end
            4,6,8,10:
            begin
                road_sprite_addr <= (i_V_Counter * TILE_SIZE) + i_H_Counter[4:0];
                o_VGA_Pixel   <= road_pixel_data;
            end
            default:
            begin
                o_VGA_Pixel <= 9'd0;
            end
        endcase
    end
end
endmodule