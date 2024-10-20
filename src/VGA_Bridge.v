///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// This module will check if you are in the visible area of the VGA.
//
// I/Os:
// To do so, it will need only a Clock as input, VGA Horizontal and Vertical Synchronizor as outputs.
// It will also need an Horizontal and Vertical Counter as outputs.
// 
// Behavior:
// This module use two local counters and increment them. One for Xs and the other for Ys.
// Once the horizontal Counter reaches H_TOTAL, it is set to 0 and the vertical Counter is incremented by 1.
// The VGA horizontal and vertical Synchronizors will return 1 if in the visible area and 0 elsewhere.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module VGA_Bridge #(
    parameter H_TOTAL        = 800,
    parameter V_TOTAL        = 525,
    parameter H_VISIBLE_AREA = 640,
    parameter H_FRONT_PORCH  = 16,
    parameter H_SYNC_PULSE   = 96,
    parameter V_VISIBLE_AREA = 480,
    parameter V_FRONT_PORCH  = 10,
    parameter V_SYNC_PULSE   = 2
)(
    input             i_Clk,
    output            o_VGA_HSync,
    output            o_VGA_VSync,
    output wire [9:0] o_V_Counter,
    output wire [9:0] o_H_Counter
);

    reg [9:0] r_h_counter = 0;    // Horizontar counter
    reg [9:0] r_v_counter = 0;    // Verticar counter

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

    assign o_VGA_HSync = (r_h_counter >= H_VISIBLE_AREA + H_FRONT_PORCH && r_h_counter < H_VISIBLE_AREA + H_FRONT_PORCH + H_SYNC_PULSE);
    assign o_VGA_VSync = (r_v_counter >= V_VISIBLE_AREA + V_FRONT_PORCH && r_v_counter < V_VISIBLE_AREA + V_FRONT_PORCH + V_SYNC_PULSE);

    assign o_H_Counter = r_h_counter;
    assign o_V_Counter = r_v_counter;
    
endmodule