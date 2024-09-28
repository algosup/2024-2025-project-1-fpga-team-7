module Sprite_Display (
    input  i_Clk,
    input  [8:0] X_Position,
    input  [8:0] Y_Position,
    output o_VGA_HSync,
    output o_VGA_VSync,
    output o_VGA_Red_2,
    output o_VGA_Grn_2,
    output o_VGA_Blu_2,
);


reg [12:0] Map[20][15];

reg [9:0] h_counter = 0; // Horizontal counter
reg [9:0] v_counter = 0; // Vertical counter

reg hsync, vsync;
reg [7:0] red, green, blue;

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
        // Simple pattern: horizontal color bars
        if (((v_counter >= Y_Position) && (v_counter < Y_Position + 32)) &&
                ((h_counter >= X_Position) && (h_counter < X_Position + 32))) 
        begin
            red <= 8'hFF;  
            green <= 8'hFF;
            blue <= 8'hFF;
        end else begin
            red <= 8'h00;  
            green <= 8'h00;
            blue <= 8'h00;
        end
    end 
    else 
    begin
        red <= 8'h00;
        green <= 8'h00;
        blue <= 8'h00;
    end
end


assign o_VGA_HSync = hsync;
assign o_VGA_VSync = vsync;
assign o_VGA_Red_2   = red;
assign o_VGA_Grn_2 = green;
assign o_VGA_Blu_2  = blue;
    
endmodule