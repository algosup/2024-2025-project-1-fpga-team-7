module Memory #(
    parameter INIT_TXT_FILE = "car_sprite.txt"
)(
    input             i_Clk,
    input      [9:0]  i_read_addr,   // 10-bit address
    output reg [8:0]  o_read_data    // 9-bit data (1 RGB VGA pixel)
);

    // 1024 memory locations, each 9 bits wide
    reg [8:0] memory [0:1023];
     
    always @(posedge i_Clk) 
    begin
        o_read_data <= memory[i_read_addr];
    end
    
    // Memory initialization from file (optional)
    initial begin
        $readmemb(INIT_TXT_FILE, memory);
    end
    
endmodule