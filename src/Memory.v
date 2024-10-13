module Memory #(
    parameter INIT_FILE = "mem_init.txt"
)(
    input i_Clk,
    input w_en,
    input r_en,
    input [4:0] w_addr,
    input [4:0] r_addr,
    input [7:0] w_data,

    output reg [7:0] r_data,
);

    reg [7:0] mem [0:31];

    always @(posedge i_Clk) 
    begin
        if (w_en == 1'b1) 
        begin 
            mem[w_addr] <= w_data;
        end
        //  Read from memory
        if (r_en == 1'b1) 
        begin
            r_data <= mem[r_addr];
        end
    end
    
    initial if (INIT_FILE) 
    begin
        $readmemb(INIT_FILE, mem);
    end
endmodule