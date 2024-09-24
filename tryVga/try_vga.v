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



reg [9:0] h_counter = 0; // Horizontal counter
reg [9:0] v_counter = 0; // Vertical counter

reg hsync, vsync;
reg [7:0] red, green, blue;

reg [15:0] sprite [15:0]; // 16x16 sprite

initial begin
    // Define a simple 16x16 square sprite (1 = white, 0 = black)
    sprite[0]  = 16'b1111111111111111;
    sprite[1]  = 16'b1111111111111111;
    sprite[2]  = 16'b1111111111111111;
    sprite[3]  = 16'b1111111111111111;
    sprite[4]  = 16'b1111111111111111;
    sprite[5]  = 16'b1111111111111111;
    sprite[6]  = 16'b1111111111111111;
    sprite[7]  = 16'b1111111111111111;
    sprite[8]  = 16'b1111111111111111;
    sprite[9]  = 16'b1111111111111111;
    sprite[10] = 16'b1111111111111111;
    sprite[11] = 16'b1111111111111111;
    sprite[12] = 16'b1111111111111111;
    sprite[13] = 16'b1111111111111111;
    sprite[14] = 16'b1111111111111111;
    sprite[15] = 16'b1111111111111111;
end

parameter SPRITE_X = 100;  // X position of sprite on the screen
parameter SPRITE_Y = 100;  // Y position of sprite on the screen


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


always @(posedge CLK) begin
    if (h_counter < H_VISIBLE_AREA && v_counter < V_VISIBLE_AREA) begin
        // Simple pattern: horizontal color bars
        if (h_counter < 213) begin
            red <= 8'hFF;  // Red color
            green <= 8'h00;
            blue <= 8'h00;
        end else if (h_counter < 426) begin
            red <= 8'h00;  // Green color
            green <= 8'hFF;
            blue <= 8'h00;
        end else begin
            red <= 8'h00;  // Blue color
            green <= 8'h00;
            blue <= 8'hFF;
        end
    end else begin
        red <= 8'h00;
        green <= 8'h00;
        blue <= 8'h00;
    end
end


assign VGA_HS = hsync;
assign VGA_VS = vsync;
assign VGA_R2   = red;
assign VGA_G2 = green;
assign VGA_B2  = blue;
    
endmodule