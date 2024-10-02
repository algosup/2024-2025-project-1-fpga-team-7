module Sprite_Definition (
    input i_Clk,
    
);



RAM_Port Character_RAM (
    .i_Clk(i_Clk),
    .i_Addr(),
    .i_Wr_DV(),
    .i_Wr_Data(),
    .i_Rd_En(),
    .o_Rd_DV(),
    .o_Rd_Data()
);
    
endmodule