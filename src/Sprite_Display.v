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

// Signals to connect to the Memory modules
wire [8:0] frog_pixel_data;
wire [8:0] car_pixel_data;
reg  [9:0] frog_sprite_addr;
reg  [9:0] car_sprite_addr;
reg        frog_read_en, car_read_en;

// Instantiate the Frog Memory
Memory frog_memory (
    .i_Clk(i_Clk),
    .i_write_en(1'b0),  // No writes during display
    .i_read_en(frog_read_en),
    .i_write_addr(10'b0),  // Not used during display
    .i_read_addr(frog_sprite_addr),
    .i_write_data(9'b0),   // Not used during display
    .i_mem_select(1'b0),   // Select frog memory
    .o_read_data(frog_pixel_data)  // Output pixel data for frog
);

// Instantiate the Car Memory
Memory car_memory (
    .i_Clk(i_Clk),
    .i_write_en(1'b0),  // No writes during display
    .i_read_en(car_read_en),
    .i_write_addr(10'b0),  // Not used during display
    .i_read_addr(car_sprite_addr),
    .i_write_data(9'b0),   // Not used during display
    .i_mem_select(1'b1),   // Select car memory
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

// task Display;
//     input  [9:0]    i_Car_X_Position;
//     input  [9:0]    i_Car_Y_Position;
//     input  [3:0]    C_NB_CARS;
//     input  [7:0]    i_Color;
//     begin
//         if (((r_v_counter >= i_Car_Y_Position) && (r_v_counter < (i_Car_Y_Position + TILE_SIZE))) &&
//             ((r_h_counter >= i_Car_X_Position) && (r_h_counter < (i_Car_X_Position + TILE_SIZE))))
//         begin
//             r_red <= 3'b111;
//             r_green <= 3'b000;
//             r_blue <= 3'b111;
//             // case (i_Color)
//             //     0: 
//             //     begin
//             //         r_red <= 3'b111;
//             //         r_green <= 3'b000;
//             //         r_blue <= 3'b111;
//             //     end
//             //     default: 
//             //     begin
//             //         r_red <= 3'b111;  
//             //         r_green <= 3'b111;
//             //         r_blue <= 3'b111;
//             //     end
//             // endcase
//         end
//     end
// endtask

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
            frog_read_en <= 1'b1;  // Enable read

            // Map 9-bit frog_pixel_data to RGB
            r_red   <= frog_pixel_data[8:6];  // Top 3 bits for Red
            r_green <= frog_pixel_data[5:3];  // Middle 3 bits for Green
            r_blue  <= frog_pixel_data[2:0];  // Bottom 3 bits for Blue
        end
        else
        begin
            frog_read_en <= 1'b0;  // Disable frog memory read when outside its area
        end

        // Display Car 1
        if ((r_v_counter >= i_Car_1Y_Position && r_v_counter < i_Car_1Y_Position + TILE_SIZE) &&
            (r_h_counter >= i_Car_1X_Position && r_h_counter < i_Car_1X_Position + TILE_SIZE))
        begin
            // The same sprite address range for all cars (0 to 1023)
            car_sprite_addr <= ((r_v_counter - i_Car_1Y_Position) * TILE_SIZE) + (r_h_counter - i_Car_1X_Position);
            car_read_en <= 1'b1;
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end

        // Display Car 2
        if ((r_v_counter >= i_Car_2Y_Position && r_v_counter < i_Car_2Y_Position + TILE_SIZE) &&
            (r_h_counter >= i_Car_2X_Position && r_h_counter < i_Car_2X_Position + TILE_SIZE))
        begin
            // The same sprite address range for all cars (0 to 1023)
            car_sprite_addr <= ((r_v_counter - i_Car_2Y_Position) * TILE_SIZE) + (r_h_counter - i_Car_2X_Position);
            car_read_en <= 1'b1;
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end

        // Display Car 3
        if ((r_v_counter >= i_Car_3Y_Position && r_v_counter < i_Car_3Y_Position + TILE_SIZE) &&
            (r_h_counter >= i_Car_3X_Position && r_h_counter < i_Car_3X_Position + TILE_SIZE))
        begin
            // The same sprite address range for all cars (0 to 1023)
            car_sprite_addr <= ((r_v_counter - i_Car_3Y_Position) * TILE_SIZE) + (r_h_counter - i_Car_3X_Position);
            car_read_en <= 1'b1;
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end

        // Display Car 4
        if ((r_v_counter >= i_Car_4Y_Position && r_v_counter < i_Car_4Y_Position + TILE_SIZE) &&
            (r_h_counter >= i_Car_4X_Position && r_h_counter < i_Car_4X_Position + TILE_SIZE))
        begin
            // The same sprite address range for all cars (0 to 1023)
            car_sprite_addr <= ((r_v_counter - i_Car_4Y_Position) * TILE_SIZE) + (r_h_counter - i_Car_4X_Position);
            car_read_en <= 1'b1;
            r_red   <= car_pixel_data[8:6];
            r_green <= car_pixel_data[5:3];
            r_blue  <= car_pixel_data[2:0];
        end
    end
    else
    begin
        car_read_en <= 1'b0;  // Disable car memory read when outside its area
    end
end

// Assign HSYNC, VSYNC, and VGA colors
assign o_VGA_HSync = r_hsync;
assign o_VGA_VSync = r_vsync;
assign o_VGA_Red_2 = r_red[2];    // MSB of red signal
assign o_VGA_Grn_2 = r_green[2];  // MSB of green signal
assign o_VGA_Blu_2 = r_blue[2];   // MSB of blue signal

endmodule

