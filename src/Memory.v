module Memory #(
    parameter INIT_FILE = "mem_init.txt"
)(
    input            i_Clk,
    input            i_write_en,
    input            i_read_en,
    input      [4:0] i_write_addr,
    input      [4:0] i_read_addr,
    input      [7:0] i_write_data,

    output reg [7:0] o_read_data,
);

    reg [7:0] r_mem [0:31];

    always @(posedge i_Clk) 
    begin
        if (i_write_en == 1'b1) 
        begin 
            r_mem[i_write_addr] <= i_write_data;
        end
        //  Read from memory
        if (i_read_en == 1'b1) 
        begin
            o_read_data <= r_mem[i_read_addr];
        end
    end
    
    initial if (INIT_FILE) 
    begin
        $readmemb(INIT_FILE, r_mem);
    end
endmodule