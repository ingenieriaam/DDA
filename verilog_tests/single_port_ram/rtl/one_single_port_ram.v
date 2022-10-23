module single_port_ram
#(
    parameter ADDR_WIDTH = 4,
    parameter DATA_WIDTH = 32,
    parameter DEPTH = 16
) 
(
    inout [DATA_WIDTH-1:0] data,

    input clk,cs,we,oe,
    input [ADDR_WIDTH-1:0] addr
);

//-------arch-------

    /*vars*/
    reg [DATA_WIDTH-1:0] tmp_data;
    reg [DATA_WIDTH-1:0] mem [DEPTH];

    always @(posedge clk ) begin
        if(cs & we)
            mem[addr] <= data;
    end
    
    always @(posedge clk ) begin
        if(cs & !we)
            tmp_data <= mem[addr];
    end

    assign data = (cs & oe & !we) ? tmp_data : 'hz;
    
endmodule