module Sprite_Display #(
    parameter TILE_SIZE      = 32,
    parameter H_VISIBLE_AREA = 640,
    parameter V_VISIBLE_AREA = 480,
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

    input  [9:0] i_V_Counter,
    input  [9:0] i_H_Counter,

    // Car Reverse
    input  [3:0] i_Reverse,

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

task Car_Display;
    input  [9:0]    i_Car_X_Position;
    input  [9:0]    i_Car_Y_Position;
    input           i_T_Reverse;

    reg [9:0]       r_Car_X_Memory;
    begin
        if (((i_V_Counter >= i_Car_Y_Position) && (i_V_Counter <= (i_Car_Y_Position + TILE_SIZE))) &&
            ((i_H_Counter >= i_Car_X_Position) && (i_H_Counter <= (i_Car_X_Position + TILE_SIZE))))
        begin
            r_Car_X_Memory = i_T_Reverse ? (TILE_SIZE - (i_H_Counter - i_Car_X_Position)) : (i_H_Counter - i_Car_X_Position);
            car_sprite_addr <= ((i_V_Counter - i_Car_Y_Position) * TILE_SIZE) + r_Car_X_Memory;
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end
    end
endtask

// Display logic
always @(posedge i_Clk) 
begin
    if (i_H_Counter < H_VISIBLE_AREA && i_V_Counter < V_VISIBLE_AREA)
    begin
        // Default background color (black)
        r_red <= 3'b000;  
        r_green <= 3'b000;
        r_blue <= 3'b000;

        // Display Frog Sprite
        if ((i_V_Counter >= i_Y_Position && i_V_Counter <= i_Y_Position + TILE_SIZE) &&
            (i_H_Counter >= i_X_Position && i_H_Counter <= i_X_Position + TILE_SIZE))
        begin
            // Calculate the address in the frog sprite memory
            frog_sprite_addr <= ((i_V_Counter - i_Y_Position) * TILE_SIZE) + (i_H_Counter - i_X_Position);

            // Map 9-bit frog_pixel_data to RGB
            r_red   <= frog_pixel_data[8:6];  // Top 3 bits for Red
            r_green <= frog_pixel_data[5:3];  // Middle 3 bits for Green
            r_blue  <= frog_pixel_data[2:0];  // Bottom 3 bits for Blue
        end

        Car_Display(i_Car_1X_Position, C_LINE_1_Y, i_Reverse[0]);
        Car_Display(i_Car_2X_Position, C_LINE_2_Y, i_Reverse[1]);
        Car_Display(i_Car_3X_Position, C_LINE_3_Y, i_Reverse[2]);
        Car_Display(i_Car_4X_Position, C_LINE_4_Y, i_Reverse[3]);

    end
end

// Assign VGA colors
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

