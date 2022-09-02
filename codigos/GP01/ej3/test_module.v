module test_module 
(
    input [31:0]        i_x0 ,
    input [1:0]         i_sel,
    input               clk  ,
    input               rst_n,
    output reg [31:0]   o_y0 ;    
);

//-----------arch-----------

    /*vars*/
    reg [31:0]  x1, x2, x3;
    reg [31:0]          y1;
    reg [31:0]         out;

    assign out = (x0+x1+x3+x3+y1) >>> 2;

    always @(posedge clk or posedge rst_n) begin
        if(! rst_n) begin
            x1 <= 0;
            x2 <= 0;
            x3 <= 0;
        end
        else if(sel==0) begin
            x3 <= x2;
            x2 <= x1;
            x1 <= x0;
        end
        else if(sel==01) begin
            x3 <= x1;
            x2 <= x0;
            x1 <= x2;
        end
        else begin
            x3 <= x3;
            x2 <= x2;
            x1 <= x1;
        end
    end

    always @(posedge clk or posedge rst_n) begin
        if (! rst_n) begin
            y1 <= 0;
            y0 <= 0;
        end
        else begin
            y1 <= y0;
            y0 <= out; 
        end
    end
    
endmodule //test_module
