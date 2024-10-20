///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// Avoids to move multiple times in one direction by pressing the button only one time.
//
// I/Os:
// It uses a Clock and a Switch state as inputs.
// As outputs, it uses a wire for the switch state.
// 
// Behavior:
// It checks the Switch state as input differs from the register while the clock reaches a predefined limit.
// If the limit isn't reached, a counter is incremented,
// else it returns the new Switch state and restart the counter. 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Debounce_Filter #(parameter C_DEBOUNCE_LIMIT = 250000)(
    input  i_Clk, 
    input  i_Switch, 
    output o_Switch
);
  
    // The counter is used to wait and cancel rebounces
    reg [14:0] r_Count = 0;

    // This register is used to only activate the button when we pressed it
    reg        r_State = 1'b0;

    always @(posedge i_Clk)
    begin
        if (i_Switch !== r_State && r_Count < C_DEBOUNCE_LIMIT)
        begin
            r_Count <= r_Count + 1;
        end
        else if (r_Count == C_DEBOUNCE_LIMIT)
        begin
            r_State <= i_Switch;
            r_Count <= 0;
        end  
        else
        begin
            r_Count <= 0;
        end
    end

    // return 0 or 1 
    assign o_Switch = r_State;

endmodule