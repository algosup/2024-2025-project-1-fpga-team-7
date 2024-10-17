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

    // Frog (Player) left corner position
    input  [9:0] i_X_Position,
    input  [8:0] i_Y_Position,

    // Car positions
    input  [9:0] i_Car_1X_Position,
    input  [9:0] i_Car_2X_Position,
    input  [9:0] i_Car_3X_Position,
    input  [9:0] i_Car_4X_Position,

    // VGA Visible Area detector (0 in both when in Visible Area)
    output       o_VGA_HSync,
    output       o_VGA_VSync,

    // VGA Colors
    output       o_VGA_Red_1,
    output       o_VGA_Red_2,
    output       o_VGA_Red_3,
    output       o_VGA_Grn_1,
    output       o_VGA_Grn_2,
    output       o_VGA_Grn_3,
    output       o_VGA_Blu_1,
    output       o_VGA_Blu_2,
    output       o_VGA_Blu_3,

);

localparam CAR_SPRITE = "car_sprite.txt";
localparam FROG_SPRITE = "frog_sprite.txt";

reg [9:0] r_h_counter = 0; // Horizontal counter
reg [9:0] r_v_counter = 0; // Vertical counter

reg       r_hsync, r_vsync;
reg [2:0] r_red, r_green, r_blue;

// Signals to connect to the Memory modules
wire [8:0] frog_pixel_data;
wire [8:0] car_pixel_data;
reg  [9:0] frog_sprite_addr;
reg  [9:0] car_sprite_addr;

// Instantiate the Frog Memory
Memory #(.INIT_TXT_FILE(FROG_SPRITE)) frog_memory (
    .i_Clk(i_Clk),
    .i_read_addr(frog_sprite_addr),
    .o_read_data(frog_pixel_data)  // Output pixel data for frog
);

// Instantiate the Car Memory
Memory #(.INIT_TXT_FILE(CAR_SPRITE)) car_memory (
    .i_Clk(i_Clk),
    .i_read_addr(car_sprite_addr),
    .o_read_data(car_pixel_data)  // Output pixel data for car
);

// Screen scanning logic
always @(posedge i_Clk) 
begin
    // Increment horizontal and vertical counters
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

// HSYNC and VSYNC signal generation
always @(posedge i_Clk) 
begin
    // Generate HSYNC
    if (r_h_counter >= H_VISIBLE_AREA + H_FRONT_PORCH &&
        r_h_counter < H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE)
        r_hsync <= 0;
    else
        r_hsync <= 1;

    // Generate VSYNC
    if (r_v_counter >= V_VISIBLE_AREA + V_FRONT_PORCH &&
        r_v_counter < V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE)
        r_vsync <= 0;
    else
        r_vsync <= 1;
end



// Display logic
always @(posedge i_Clk) 
begin
    if (r_h_counter < H_VISIBLE_AREA && r_v_counter < V_VISIBLE_AREA)
    begin
        // Default background color (black)
        r_red <= 3'b000;  
        r_green <= 3'b000;
        r_blue <= 3'b000;

        // Display Frog Sprite
        if ((r_v_counter >= i_Y_Position && r_v_counter < i_Y_Position + TILE_SIZE) &&
            (r_h_counter >= i_X_Position && r_h_counter < i_X_Position + TILE_SIZE))
        begin
            // Calculate the address in the frog sprite memory
            frog_sprite_addr <= ((r_v_counter - i_Y_Position) * TILE_SIZE) + (r_h_counter - i_X_Position);

            // Map 9-bit frog_pixel_data to RGB
            r_red   <= frog_pixel_data[8:6];  // Top 3 bits for Red
            r_green <= frog_pixel_data[5:3];  // Middle 3 bits for Green
            r_blue  <= frog_pixel_data[2:0];  // Bottom 3 bits for Blue
        end
        else

        // Display Car 1
        if ((r_v_counter >= C_LINE_1_Y && r_v_counter < C_LINE_1_Y + TILE_SIZE) &&
            (r_h_counter >= i_Car_1X_Position && r_h_counter < i_Car_1X_Position + TILE_SIZE))
        begin
            // The same sprite address range for all cars (0 to 1023)
            car_sprite_addr <= ((r_v_counter - C_LINE_1_Y) * TILE_SIZE) + (r_h_counter - i_Car_1X_Position);
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end

        // Display Car 2
        if ((r_v_counter >= C_LINE_2_Y && r_v_counter < C_LINE_2_Y + TILE_SIZE) &&
            (r_h_counter >= i_Car_2X_Position && r_h_counter < i_Car_2X_Position + TILE_SIZE))
        begin
            // The same sprite address range for all cars (0 to 1023)
            car_sprite_addr <= ((r_v_counter - C_LINE_2_Y) * TILE_SIZE) + (r_h_counter - i_Car_2X_Position);
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end

        // Display Car 3
        if ((r_v_counter >= C_LINE_3_Y && r_v_counter < C_LINE_3_Y + TILE_SIZE) &&
            (r_h_counter >= i_Car_3X_Position && r_h_counter < i_Car_3X_Position + TILE_SIZE))
        begin
            // The same sprite address range for all cars (0 to 1023)
            car_sprite_addr <= ((r_v_counter - C_LINE_3_Y) * TILE_SIZE) + (r_h_counter - i_Car_3X_Position);
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end

        // Display Car 4
        if ((r_v_counter >= C_LINE_4_Y && r_v_counter < C_LINE_4_Y + TILE_SIZE) &&
            (r_h_counter >= i_Car_4X_Position && r_h_counter < i_Car_4X_Position + TILE_SIZE))
        begin
            // The same sprite address range for all cars (0 to 1023)
            car_sprite_addr <= ((r_v_counter - C_LINE_4_Y) * TILE_SIZE) + (r_h_counter - i_Car_4X_Position);
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end
    end
end

// Assign HSYNC, VSYNC, and VGA colors
assign o_VGA_HSync = r_hsync;
assign o_VGA_VSync = r_vsync;
assign o_VGA_Red_1 = r_red[0];    // LSB of red signal
assign o_VGA_Red_2 = r_red[1];    // Middle bit of red signal
assign o_VGA_Red_3 = r_red[2];    // MSB of red signal
assign o_VGA_Grn_1 = r_green[0];  // LSB of green signal
assign o_VGA_Grn_2 = r_green[1];  // Middle bit of green signal
assign o_VGA_Grn_3 = r_green[2];  // MSB of green signal
assign o_VGA_Blu_1 = r_blue[0];   // LSB of blue signal
assign o_VGA_Blu_2 = r_blue[1];   // Middle bit of blue signal
assign o_VGA_Blu_3 = r_blue[2];   // MSB of blue signal

endmodule

