// This module avoids what is called Rebounce when a button is pressed.
// Avoid to click many times at once by accident.
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