///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// Activate and initialize block RAM. Read in the RAM.
//
// I/Os:
// It needs a Clock and an address to read as inputs.
// As output, it needs a register to store data.
// 
// Behavior:
// Creates the memory.
// Initializes it from a text file in binary.
// It returns in the data register the data stored in the array at the input address.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
module Memory #(
    parameter INIT_TXT_FILE = "car_sprite.txt"
)(
    input             i_Clk,         // Clock
    input      [9:0]  i_read_addr,   // 10-bit address
    output reg [8:0]  o_read_data    // 9-bit data (1 RGB VGA pixel)
);

    // 1024 memory locations, each 9 bits wide
    reg [8:0] memory [0:1023];
     
    always @(posedge i_Clk) 
    begin
        o_read_data <= memory[i_read_addr]; // Read data from memory at 'read address'
    end
    
    // Memory initialization from file (optional)
    initial begin
        $readmemb(INIT_TXT_FILE, memory);
    end
    
endmodule