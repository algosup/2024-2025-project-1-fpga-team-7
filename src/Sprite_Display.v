///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// Display on the screen the sprites at their locations or the background if there is no sprite on the pixel.
//
// I/Os:
// It needs a Clock, a wire for the frog's direction, two for the frog's X and Y positions, one for each cars'
// X position, two for the Vertical and Horizontal Counter, another for the Background Pixel, and a last one 
// for the reverse car state as inputs.
// As outputs, it needs wires for the VGA components (here 3/colors).
// 
// Behavior:
// It initiates the memory for the car and frog sprites.
// If there is no car or frog on a pixel, it prints the background pixel.
// Else if there is the frog, it looks at the direction of it and rotates the frog given to it.
// Else it prints the car and reverses it according to the reverse register.
// Lastly, the background is printed if the pixel in the car or frog sprite is equal to 9'b111101110.
// It returns the 9 VGA components.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Sprite_Display #(
    parameter TILE_SIZE      = 32,
    parameter H_VISIBLE_AREA = 640,
    parameter V_VISIBLE_AREA = 480,
)(
    // Clock
    input        i_Clk,

    // Switches
    input  [1:0] i_Frog_Direction,

    // Frog (Player) left corner position
    input  [9:0] i_X_Position,
    input  [8:0] i_Y_Position,

    // Car positions
    input  [9:0] i_Car_1X_Position,
    input  [9:0] i_Car_2X_Position,
    input  [9:0] i_Car_3X_Position,
    input  [9:0] i_Car_4X_Position,
    input  [9:0] i_Car_5X_Position,

    // Cursor X and Y position to display
    input  [9:0] i_V_Counter,
    input  [9:0] i_H_Counter,

    // Background pixel
    input  [8:0] i_Background_Pixel,

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

    localparam CAR_SPRITE = "sprites/car_sprite.txt";
    localparam FROG_SPRITE = "sprites/frog_sprite.txt";

    reg [8:0] r_VGA_Pixel;                      // Store the VGA components of the pixel that will be displayed

    // Signals to connect to the Memory modules
    reg  [9:0] r_frog_sprite_addr;
    reg  [9:0] r_car_sprite_addr;
    reg  [4:0] r_Car_X_Memory;
    reg  [4:0] r_Frog_X_Memory;
    reg  [4:0] r_Frog_Y_Memory;
    wire [8:0] w_frog_pixel_data;
    wire [8:0] w_car_pixel_data;

    // Instantiate the Frog Memory
    Memory #(.INIT_TXT_FILE(FROG_SPRITE)) frog_memory (
        .i_Clk(i_Clk),
        .i_read_addr(r_frog_sprite_addr),
        .o_read_data(w_frog_pixel_data)  // Output pixel data for frog
    );

    // Instantiate the Car Memory
    Memory #(.INIT_TXT_FILE(CAR_SPRITE)) car_memory (
        .i_Clk(i_Clk),
        .i_read_addr(r_car_sprite_addr),
        .o_read_data(w_car_pixel_data)  // Output pixel data for car
    );

    // Display car and rotate the sprite if needed
    task Car_Display;
        input  [9:0]    i_Car_X_Position;
        input  [8:0]    i_Car_Y_Position;
        input           i_T_Reverse;
        begin
            if (((i_V_Counter >= i_Car_Y_Position) && (i_V_Counter <= (i_Car_Y_Position + TILE_SIZE))) &&
                ((i_H_Counter >= i_Car_X_Position) && (i_H_Counter <= (i_Car_X_Position + TILE_SIZE))))
            begin
                r_Car_X_Memory = i_T_Reverse ? (i_H_Counter - i_Car_X_Position) : (TILE_SIZE - (i_H_Counter - i_Car_X_Position));
                r_car_sprite_addr <= ((i_V_Counter - i_Car_Y_Position) * TILE_SIZE) + r_Car_X_Memory;
                if (w_car_pixel_data != 9'b111101110)
                begin
                    if (w_car_pixel_data == 9'b111000000) 
                    begin
                        case(i_Car_Y_Position)
                            C_LINE_1_Y,C_LINE_4_Y:
                                begin
                                    r_VGA_Pixel <= w_car_pixel_data;
                                end
                            C_LINE_2_Y,C_LINE_5_Y:
                                begin
                                    r_VGA_Pixel <= 000111000;
                                end
                            C_LINE_3_Y,C_LINE_6_Y:
                                begin
                                    r_VGA_Pixel <= 000000111;
                                end
                        endcase
                    end
                    else
                    begin
                        r_VGA_Pixel <= w_car_pixel_data;
                    end
                end
            end
        end
    endtask

    // Display logic
    always @(posedge i_Clk) 
    begin
        if (i_H_Counter < H_VISIBLE_AREA && i_V_Counter < V_VISIBLE_AREA)
        begin
            // Default background color
            r_VGA_Pixel <= i_Background_Pixel;
    
            // Display Frog Sprite
            if ((i_V_Counter >= i_Y_Position && i_V_Counter <= i_Y_Position + TILE_SIZE) &&
                (i_H_Counter >= i_X_Position && i_H_Counter <= i_X_Position + TILE_SIZE))
            begin
                case (i_Frog_Direction)
                    0:    // Facing up
                    begin
                        r_Frog_X_Memory = (i_H_Counter - i_X_Position);
                        r_Frog_Y_Memory = (i_V_Counter - i_Y_Position);
                        r_frog_sprite_addr <= (r_Frog_Y_Memory * TILE_SIZE) + (r_Frog_X_Memory);
                    end
                    1:    // Facing left
                    begin
                        r_Frog_X_Memory = (i_H_Counter - i_X_Position);
                        r_Frog_Y_Memory = (i_V_Counter - i_Y_Position);
                        r_frog_sprite_addr <= (r_Frog_Y_Memory) + (r_Frog_X_Memory * TILE_SIZE);
                    end
                    2:    // Facing right
                    begin
                        r_Frog_X_Memory = (TILE_SIZE - (i_H_Counter - i_X_Position));
                        r_Frog_Y_Memory = (i_V_Counter - i_Y_Position);
                        r_frog_sprite_addr <= (r_Frog_Y_Memory) + (r_Frog_X_Memory * TILE_SIZE);
                    end
                    3:    // Facing down
                    begin
                        r_Frog_X_Memory = (i_H_Counter - i_X_Position);
                        r_Frog_Y_Memory = (TILE_SIZE - (i_V_Counter - i_Y_Position));
                        r_frog_sprite_addr <= (r_Frog_Y_Memory * TILE_SIZE) + (r_Frog_X_Memory);
                    end
                endcase

                // Map 9-bit w_frog_pixel_data to RGB
                if (w_frog_pixel_data != 9'b111101110)
                begin
                    r_VGA_Pixel <= w_frog_pixel_data;    
                end
            end
            Car_Display(i_Car_1X_Position, C_LINE_1_Y, i_Reverse[0]);
            Car_Display(i_Car_2X_Position, C_LINE_2_Y, i_Reverse[1]);
            Car_Display(i_Car_3X_Position, C_LINE_3_Y, i_Reverse[2]);
            Car_Display(i_Car_4X_Position, C_LINE_4_Y, i_Reverse[3]);
            Car_Display(i_Car_5X_Position, C_LINE_5_Y, i_Reverse[0]);
            Car_Display(i_Car_2X_Position, C_LINE_6_Y, i_Reverse[1]);
        end
        else
        begin
            r_VGA_Pixel <= 9'd0;
        end
    end

    // Assign VGA colors
    assign o_VGA_Blu_1 = r_VGA_Pixel[0];    // LSB of red signal
    assign o_VGA_Blu_2 = r_VGA_Pixel[1];    // Middle bit of red signal
    assign o_VGA_Blu_3 = r_VGA_Pixel[2];    // MSB of red signal
    assign o_VGA_Grn_1 = r_VGA_Pixel[3];  // LSB of green signal
    assign o_VGA_Grn_2 = r_VGA_Pixel[4];  // Middle bit of green signal
    assign o_VGA_Grn_3 = r_VGA_Pixel[5];  // MSB of green signal
    assign o_VGA_Red_1 = r_VGA_Pixel[6];   // LSB of blue signal
    assign o_VGA_Red_2 = r_VGA_Pixel[7];   // Middle bit of blue signal
    assign o_VGA_Red_3 = r_VGA_Pixel[8];   // MSB of blue signal

endmodule

