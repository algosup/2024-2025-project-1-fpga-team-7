module background (
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
        if (v_counter < 128) begin
            red <= 8'h00;  // Red color
            green <= 8'h00;
            blue <= 8'h00;
        end else if (v_counter < 160) begin
                if ((h_counter > 5 && h_counter < 20) || (h_counter > 35 && h_counter < 50) || (h_counter > 65 && h_counter < 80) || (h_counter > 95 && h_counter < 110) || (h_counter > 125 && h_counter < 140) || (h_counter > 155 && h_counter < 170) || (h_counter > 185 && h_counter < 200) || (h_counter > 215 && h_counter < 230) || (h_counter > 245 && h_counter < 260) || (h_counter > 275 && h_counter < 290) || (h_counter > 305 && h_counter < 320) || (h_counter > 335 && h_counter < 350) || (h_counter > 365 && h_counter < 380) || (h_counter > 395 && h_counter < 410) || (h_counter > 425 && h_counter < 440) || (h_counter > 455 && h_counter < 470)) begin
                    red <= 8'hFF;  // Red color
                    green <= 8'hFF;
                    blue <= 8'hFF;
                end else begin
                    red <= 8'h00;  // Red color
                    green <= 8'h00;
                    blue <= 8'h00;
                end    
        end else if (v_counter < 192) begin
            red <= 8'h00;  // Red color
            green <= 8'h00;
            blue <= 8'h00;
        end else if (v_counter < 224) begin
            red <= 8'hFF;  // Red color
            green <= 8'hFF;
            blue <= 8'hFF;
        end else if (v_counter < 256) begin
            red <= 8'h00;  // Red color
            green <= 8'h00;
            blue <= 8'h00;
        end else if (v_counter < 288) begin
            red <= 8'hFF;  // Red color
            green <= 8'hFF;
            blue <= 8'hFF;
        end else if (v_counter < 320) begin
            red <= 8'h00;  // Red color
            green <= 8'h00;
            blue <= 8'h00;
        end else if (v_counter < 352) begin
            red <= 8'hFF;  // Red color
            green <= 8'hFF;
            blue <= 8'hFF;
        end else if (v_counter < 368) begin
            red <= 8'h00;  // Red color
            green <= 8'h00;
            blue <= 8'h00;
        end else if (v_counter < 416) begin
            red <= 8'hFF;  // Green color
            green <= 8'hFF;
            blue <= 8'hFF;
        end else begin
            red <= 8'h00;  // Blue color
            green <= 8'h00;
            blue <= 8'h00;
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