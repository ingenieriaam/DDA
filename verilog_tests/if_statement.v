module if_statement 
(
    input   x0,x1,x2,x3, // input data
    input   [1:0] sel, 
    output  reg y
);
    
    always @(*) begin:selectorMux
        if(sel==2'b00) begin
            y <= x0;
        end
        else if(sel==2'b01) begin
            y <= x1;
        end
        else if(sel==2'b10) begin
            y <= x2;
        end
        else begin
            y <= x3;
        end
    end
endmodule