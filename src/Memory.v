module Memory (
    input             i_Clk,
    input             i_write_en,
    input             i_read_en,
    input      [9:0]  i_write_addr,  // 10-bit address for 1024 locations
    input      [9:0]  i_read_addr,   // 10-bit address for 1024 locations
    input      [8:0]  i_write_data,  // 8-bit data (1 pixel)
    input             i_mem_select,  // Selects frog_mem (0) or car_mem (1)

    output reg [8:0]  o_read_data    // 8-bit data (1 pixel)
);

    // 1024 memory locations, each 8 bits wide
    reg [8:0] frog_mem [0:1023]; 
    reg [8:0] car_mem [0:1023];
     

    always @(posedge i_Clk) 
    begin
        // Write to frog memory
        if (i_write_en == 1'b1) 
        begin
            if (i_mem_select == 1'b0)  // Select frog memory
            begin
                frog_mem[i_write_addr] <= i_write_data;
            end
            else  // Select car memory
            begin
                car_mem[i_write_addr] <= i_write_data;
            end
        end

        // Read from memory
        if (i_read_en == 1'b1) 
        begin
            if (i_mem_select == 1'b0)  // Read from frog memory
            begin
                o_read_data <= frog_mem[i_read_addr];
            end
            else  // Read from car memory
            begin
                o_read_data <= car_mem[i_read_addr];
            end
        end
    end
    
    // Memory initialization from file (optional)
    initial begin
        $readmemb("frog_sprite.txt", frog_mem);
        $readmemb("car_sprite.txt", car_mem);
    end
endmodule