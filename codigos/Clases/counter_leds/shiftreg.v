/**
Secuencia:
1 0 0 0
0 1 0 0
0 0 1 0
0 0 0 1 
*/

//`define forloop
`define shifter 1
//`define concatenate

module shiftreg 
#(
    parameter    NB_LEDS  = 12,
) 
(
    output [OUTPUT_WIDTH - 1 : 0]   o_led,

    input       i_valid,
    input       i_rst,
    input       clk
);
    
//-----------arch-----------

    /* vars */
    reg [NB_LEDS-1 : 0] shiftreg_r;

    always @(posedge clk) begin : shifter
        if(i_rst) begin
            shiftreg_r <= {{NB_LEDS-1{1'b0}},1'b1};
        end 
        else if (i_valid) begin
            `ifdef shifter
                /* opción 1 */
                shiftreg_r      <= shiftreg_r << 1;       //solo desplazamiento
                shiftreg_r[0]   <= shiftreg_r[NB_LEDS-1]; // conexion de extremos 
            `endif

            `ifdef forloop
                /*opcion 2*/
                for (ptr = 0; ptr<NB_LEDS-1 ;ptr=ptr+1 ) begin
                    shiftreg_r[ptr+1] <= shiftreg_r[ptr];
                end
                shiftreg_r[0]   <= shiftreg_r[NB_LEDS-1];
            `endif

            `ifdef concatenate    
                /*opcion 3*/
                shiftreg_r <= {shiftreg_r[2:0], shiftreg_r[NB_LEDS]};
            `endif
        end
        else begin
            shiftreg_r <= shiftreg_r;
        end
    end

    assign  o_led = shiftreg_r; 
endmodule  //shiftreg
