module try_vga (
    input CLK,
    output VGA_HS,
    output VGA_VS,
    output VGA_R2,
    output VGA_G2,
    output VGA_B2,
);
parameter H_VISIBLE_AREA = 640;
parameter H_FRONT_PORCH  = 18;
parameter H_SYNC_PULSE   = 92;
parameter H_BACK_PORCH   = 50;
parameter H_TOTAL        = H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;

parameter V_VISIBLE_AREA = 480;
parameter V_FRONT_PORCH  = 10;
parameter V_SYNC_PULSE   = 12;
parameter V_BACK_PORCH   = 33;
parameter V_TOTAL        = V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;

parameter SPRITE_X = 100;  // X position of sprite on the screen
parameter SPRITE_Y = 100;  // Y position of sprite on the screen

parameter SPRITE2_X = 200;  // X position of sprite2
parameter SPRITE2_Y = 300;  // Y position of sprite2

reg [9:0] h_counter = 0; // Horizontal counter
reg [9:0] v_counter = 0; // Vertical counter

reg hsync, vsync;
reg [7:0] red, green, blue;

reg [23:0] sprite [15:0][15:0]; // 16x16 sprite
reg [23:0] sprite2 [15:0][15:0]; // 16x16 sprite

wire [3:0] sprite_x;  
wire [3:0] sprite_y;
assign sprite_x = h_counter - SPRITE_X;
assign sprite_y = v_counter - SPRITE_Y;


wire [3:0] sprite2_x;  
wire [3:0] sprite2_y;
assign sprite2_x = h_counter - SPRITE_X2;
assign sprite2_y = v_counter - SPRITE_Y2;

reg [23:0] r_green = 24'hFF0000; // Green color for sprite

// Sprite definition with green (24'h00FF00) for 1s and black (24'h000000) for 0s
always @(posedge CLK) begin
        sprite[0][0] <= r_green; sprite[0][1] <= 24'h000000; sprite[0][2] <= 24'h000000; sprite[0][3] <= 24'h000000;
        sprite[0][4] <= 24'h000000; sprite[0][5] <= 24'h000000; sprite[0][6] <= 24'h000000; sprite[0][7] <= 24'h000000;

        sprite[1][0] <= 24'h000000; sprite[1][1] <= 24'h000000; sprite[1][2] <= 24'h000000; sprite[1][3] <= 24'h000000;
        sprite[1][4] <= 24'h000000; sprite[1][5] <= 24'h000000; sprite[1][6] <= 24'h000000; sprite[1][7] <= 24'h000000;

        sprite[2][0] <= 24'h000000; sprite[2][1] <= 24'h000000; sprite[2][2] <= 24'h000000; sprite[2][3] <= 24'h000000;
        sprite[2][4] <= 24'h000000; sprite[2][5] <= 24'h000000; sprite[2][6] <= 24'h000000; sprite[2][7] <= 24'h000000;

        sprite[3][0] <= 24'h000000; sprite[3][1] <= r_green; sprite[3][2] <= 24'h00FF00; sprite[3][3] <= 24'h000000;
        sprite[3][4] <= 24'h000000; sprite[3][5] <= 24'h00FF00; sprite[3][6] <= 24'h00FF00; sprite[3][7] <= 24'h000000;

        sprite[4][0] <= 24'h000000; sprite[4][1] <= 24'h00FF00; sprite[4][2] <= 24'h000000; sprite[4][3] <= 24'h00FF00;
        sprite[4][4] <= 24'h000000; sprite[4][5] <= 24'h00FF00; sprite[4][6] <= 24'h000000; sprite[4][7] <= 24'h00FF00;

        sprite[5][0] <= 24'h000000; sprite[5][1] <= 24'h00FF00; sprite[5][2] <= 24'h000000; sprite[5][3] <= 24'h00FF00;
        sprite[5][4] <= 24'h00FF00; sprite[5][5] <= 24'h000000; sprite[5][6] <= 24'h00FF00; sprite[5][7] <= 24'h00FF00;

        sprite[6][0] <= 24'h000000; sprite[6][1] <= 24'h00FF00; sprite[6][2] <= 24'h00FF00; sprite[6][3] <= 24'h000000;
        sprite[6][4] <= 24'h000000; sprite[6][5] <= 24'h00FF00; sprite[6][6] <= 24'h00FF00; sprite[6][7] <= 24'h000000;

        sprite[7][0] <= 24'h00FF00; sprite[7][1] <= 24'h000000; sprite[7][2] <= 24'h00FF00; sprite[7][3] <= 24'h00FF00;
        sprite[7][4] <= 24'h000000; sprite[7][5] <= 24'h00FF00; sprite[7][6] <= 24'h000000; sprite[7][7] <= 24'h00FF00;

        sprite[8][0] <= 24'h000000; sprite[8][1] <= 24'h00FF00; sprite[8][2] <= 24'h000000; sprite[8][3] <= 24'h00FF00;
        sprite[8][4] <= 24'h000000; sprite[8][5] <= 24'h000000; sprite[8][6] <= 24'h00FF00; sprite[8][7] <= 24'h000000;

        sprite[9][0] <= 24'h00FF00; sprite[9][1] <= 24'h000000; sprite[9][2] <= 24'h000000; sprite[9][3] <= 24'h000000;
        sprite[9][4] <= 24'h000000; sprite[9][5] <= 24'h000000; sprite[9][6] <= 24'h000000; sprite[9][7] <= 24'h00FF00;

        sprite[10][0] <= 24'h000000; sprite[10][1] <= 24'h00FF00; sprite[10][2] <= 24'h00FF00; sprite[10][3] <= 24'h000000;
        sprite[10][4] <= 24'h000000; sprite[10][5] <= 24'h00FF00; sprite[10][6] <= 24'h00FF00; sprite[10][7] <= 24'h000000;

        sprite[11][0] <= 24'h00FF00; sprite[11][1] <= 24'h000000; sprite[11][2] <= 24'h00FF00; sprite[11][3] <= 24'h00FF00;
        sprite[11][4] <= 24'h00FF00; sprite[11][5] <= 24'h00FF00; sprite[11][6] <= 24'h000000; sprite[11][7] <= 24'h000000;

        sprite[12][0] <= 24'h000000; sprite[12][1] <= 24'h00FF00; sprite[12][2] <= 24'h000000; sprite[12][3] <= 24'h000000;
        sprite[12][4] <= 24'h00FF00; sprite[12][5] <= 24'h000000; sprite[12][6] <= 24'h00FF00; sprite[12][7] <= 24'h000000;

        sprite[13][0] <= 24'h000000; sprite[13][1] <= 24'h00FF00; sprite[13][2] <= 24'h000000; sprite[13][3] <= 24'h000000;
        sprite[13][4] <= 24'h00FF00; sprite[13][5] <= 24'h00FF00; sprite[13][6] <= 24'h00FF00; sprite[13][7] <= 24'h00FF00;

        sprite[14][0] <= 24'h00FF00; sprite[14][1] <= 24'h000000; sprite[14][2] <= 24'h00FF00; sprite[14][3] <= 24'h00FF00;
        sprite[14][4] <= 24'h000000; sprite[14][5] <= 24'h00FF00; sprite[14][6] <= 24'h00FF00; sprite[14][7] <= 24'h000000;

        sprite[15][0] <= 24'h00FF00; sprite[15][1] <= 24'h00FF00; sprite[15][2] <= 24'h00FF00; sprite[15][3] <= 24'h00FF00;
        sprite[15][4] <= 24'h00FF00; sprite[15][5] <= 24'h00FF00; sprite[15][6] <= 24'h00FF00; sprite[15][7] <= 24'h00FF00;

        sprite2[0][0] <= 24'h000000; sprite2[0][1] <= 24'h000000; sprite2[0][2] <= 24'h000000; sprite2[0][3] <= 24'h000000;
        sprite2[0][4] <= 24'h000000; sprite2[0][5] <= 24'h000000; sprite2[0][6] <= 24'h000000; sprite2[0][7] <= 24'h000000;

        sprite2[1][0] <= 24'h000000; sprite2[1][1] <= 24'h000000; sprite2[1][2] <= 24'h000000; sprite2[1][3] <= 24'h000000;
        sprite2[1][4] <= 24'h000000; sprite2[1][5] <= 24'h000000; sprite2[1][6] <= 24'h000000; sprite2[1][7] <= 24'h000000;

        sprite2[2][0] <= 24'h000000; sprite2[2][1] <= 24'h000000; sprite2[2][2] <= 24'h000000; sprite2[2][3] <= 24'h000000;
        sprite2[2][4] <= 24'h000000; sprite2[2][5] <= 24'h000000; sprite2[2][6] <= 24'h000000; sprite2[2][7] <= 24'h000000;

        sprite2[3][0] <= 24'h000000; sprite2[3][1] <= 24'h00FF00; sprite2[3][2] <= 24'h00FF00; sprite2[3][3] <= 24'h000000;
        sprite2[3][4] <= 24'h000000; sprite2[3][5] <= 24'h00FF00; sprite2[3][6] <= 24'h00FF00; sprite2[3][7] <= 24'h000000;

        sprite2[4][0] <= 24'h000000; sprite2[4][1] <= 24'h00FF00; sprite2[4][2] <= 24'h000000; sprite2[4][3] <= 24'h00FF00;
        sprite2[4][4] <= 24'h000000; sprite2[4][5] <= 24'h00FF00; sprite2[4][6] <= 24'h000000; sprite2[4][7] <= 24'h00FF00;

        sprite2[5][0] <= 24'h000000; sprite2[5][1] <= 24'h00FF00; sprite2[5][2] <= 24'h000000; sprite2[5][3] <= 24'h00FF00;
        sprite2[5][4] <= 24'h00FF00; sprite2[5][5] <= 24'h000000; sprite2[5][6] <= 24'h00FF00; sprite2[5][7] <= 24'h00FF00;

        sprite2[6][0] <= 24'h000000; sprite2[6][1] <= 24'h00FF00; sprite2[6][2] <= 24'h00FF00; sprite2[6][3] <= 24'h000000;
        sprite2[6][4] <= 24'h000000; sprite2[6][5] <= 24'h00FF00; sprite2[6][6] <= 24'h00FF00; sprite2[6][7] <= 24'h000000;

        sprite2[7][0] <= 24'h00FF00; sprite2[7][1] <= 24'h000000; sprite2[7][2] <= 24'h00FF00; sprite2[7][3] <= 24'h00FF00;
        sprite2[7][4] <= 24'h000000; sprite2[7][5] <= 24'h00FF00; sprite2[7][6] <= 24'h000000; sprite2[7][7] <= 24'h00FF00;

        sprite2[8][0] <= 24'h000000; sprite2[8][1] <= 24'h00FF00; sprite2[8][2] <= 24'h000000; sprite2[8][3] <= 24'h00FF00;
        sprite2[8][4] <= 24'h000000; sprite2[8][5] <= 24'h000000; sprite2[8][6] <= 24'h00FF00; sprite2[8][7] <= 24'h000000;

        sprite2[9][0] <= 24'h00FF00; sprite2[9][1] <= 24'h000000; sprite2[9][2] <= 24'h000000; sprite2[9][3] <= 24'h000000;
        sprite2[9][4] <= 24'h000000; sprite2[9][5] <= 24'h000000; sprite2[9][6] <= 24'h000000; sprite2[9][7] <= 24'h00FF00;

        sprite2[10][0] <= 24'h000000; sprite2[10][1] <= 24'h00FF00; sprite2[10][2] <= 24'h00FF00; sprite2[10][3] <= 24'h000000;
        sprite2[10][4] <= 24'h000000; sprite2[10][5] <= 24'h00FF00; sprite2[10][6] <= 24'h00FF00; sprite2[10][7] <= 24'h000000;

        sprite2[11][0] <= 24'h00FF00; sprite2[11][1] <= 24'h000000; sprite2[11][2] <= 24'h00FF00; sprite2[11][3] <= 24'h00FF00;
        sprite2[11][4] <= 24'h00FF00; sprite2[11][5] <= 24'h00FF00; sprite2[11][6] <= 24'h000000; sprite2[11][7] <= 24'h000000;

        sprite2[12][0] <= 24'h000000; sprite2[12][1] <= 24'h00FF00; sprite2[12][2] <= 24'h000000; sprite2[12][3] <= 24'h000000;
        sprite2[12][4] <= 24'h00FF00; sprite2[12][5] <= 24'h000000; sprite2[12][6] <= 24'h00FF00; sprite2[12][7] <= 24'h000000;

        sprite2[13][0] <= 24'h000000; sprite2[13][1] <= 24'h00FF00; sprite2[13][2] <= 24'h000000; sprite2[13][3] <= 24'h000000;
        sprite2[13][4] <= 24'h00FF00; sprite2[13][5] <= 24'h00FF00; sprite2[13][6] <= 24'h00FF00; sprite2[13][7] <= 24'h00FF00;

        sprite2[14][0] <= 24'h00FF00; sprite2[14][1] <= 24'h000000; sprite2[14][2] <= 24'h00FF00; sprite2[14][3] <= 24'h00FF00;
        sprite2[14][4] <= 24'h000000; sprite2[14][5] <= 24'h00FF00; sprite2[14][6] <= 24'h00FF00; sprite2[14][7] <= 24'h000000;

        sprite2[15][0] <= 24'h00FF00; sprite2[15][1] <= 24'h00FF00; sprite2[15][2] <= 24'h00FF00; sprite2[15][3] <= 24'h00FF00;
        sprite2[15][4] <= 24'h00FF00; sprite2[15][5] <= 24'h00FF00; sprite2[15][6] <= 24'h00FF00; sprite2[15][7] <= 24'h00FF00;
end



always @(posedge CLK) begin
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



always @(posedge CLK) begin
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


// Sprite drawing logic
// Sprite drawing logic
always @(posedge CLK) begin
    if (h_counter < H_VISIBLE_AREA && v_counter < V_VISIBLE_AREA) begin
        // Initialize default background color
        red <= 8'h00;
        green <= 8'h00;
        blue <= 8'h00;

        // Check if the pixel falls inside sprite1 area
        if ((h_counter >= SPRITE_X && h_counter < SPRITE_X + 16) &&
            (v_counter >= SPRITE_Y && v_counter < SPRITE_Y + 16)) begin
            {red, green, blue} <= sprite[sprite_y][sprite_x];
        end
        
        // Check if the pixel falls inside sprite2 area
        if ((h_counter >= SPRITE2_X && h_counter < SPRITE2_X + 16) &&
            (v_counter >= SPRITE2_Y && v_counter < SPRITE2_Y + 16)) begin
            {red, green, blue} <= sprite2[sprite2_y][sprite2_x];
        end
    end else begin
        // Outside visible area (blanking)
        red <= 8'h00;
        green <= 8'h00;
        blue <= 8'h00;
    end
end



// Assign VGA sync and color outputs (1-bit for each color channel)
assign VGA_HS = hsync;
assign VGA_VS = vsync;
assign VGA_R2 = red;  // Use the MSB of red for 1-bit output
assign VGA_G2 = green; // Use the MSB of green for 1-bit output
assign VGA_B2 = blue;  // Use the MSB of blue for 1-bit output

endmodule
    
