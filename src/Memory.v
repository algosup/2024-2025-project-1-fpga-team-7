module Memory 

#(parameter
    INIT_TXT_FILE = "car_sprite.txt"
)(
    input             i_Clk,
    input             i_write_en,
    input             i_read_en,
    input      [9:0]  i_write_addr,  // 10-bit address for 1024 locations
    input      [9:0]  i_read_addr,   // 10-bit address for 1024 locations
    input      [8:0]  i_write_data,  // 9-bit data (1 RGB VGA pixel)

    output reg [8:0]  o_read_data    // 9-bit data (1 RGB VGA pixel)
);

    // 1024 memory locations, each 9 bits wide
    reg [8:0] memory [0:1023];
     
    always @(posedge i_Clk) 
    begin
        // Write to frog memory
        if (i_write_en == 1'b1) 
        begin
            memory[i_write_addr] <= i_write_data;
        end

        // Read from memory
        if (i_read_en == 1'b1) 
        begin
            o_read_data <= memory[i_read_addr];
        end
    end
    
    // Memory initialization from file (optional)
    initial begin
        $readmemb(INIT_TXT_FILE, memory);
    end
    
endmodule


/*

module Memory (
    input             i_Clk,
    input             i_write_en,
    input             i_read_en,
    input      [9:0]  i_write_addr,  // 10-bit address for 1024 locations
    input      [9:0]  i_read_addr,   // 10-bit address for 1024 locations
    input      [8:0]  i_write_data,  // 9-bit data (1 RGB VGA pixel)

    output reg [8:0]  o_read_data    // 9-bit data (1 RGB VGA pixel)
);

    // 1024 memory locations, each 8 bits wide
    reg [8:0] memory [0:1023];
     
    always @(posedge i_Clk) 
    begin
        // Write to frog memory
        if (i_write_en == 1'b1) 
        begin
            memory[i_write_addr] <= i_write_data;
        end

        // Read from memory
        if (i_read_en == 1'b1) 
        begin
            o_read_data <= memory[i_read_addr];
        end
    end

*/