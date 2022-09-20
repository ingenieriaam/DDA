module count 
#(
    // modificables, este valor es default
    parameter NB_SW      = 3;
    parameter NB_COUNT   = 32;
)
(
    output o_valid          ,

    input [NB_SW-1:0] i_sw  ,
    input             clk   ,
    input             i_rst ,
    
);

//-----------arch-----------
    localparam R0 = (2**(NB_COUNT-10))-1; //2^22
    localparam R1 = (2**(NB_COUNT-9) )-1;
    localparam R2 = (2**(NB_COUNT-8) )-1;
    localparam R3 = (2**(NB_COUNT-7) )-1;

    /* vars */
    wire [NB_COUNT-1:0] limit_ref;
    reg  [NB_COUNT-1:0] counter  ;
    reg                 valid    ;

    /*asignación continua, MUX con prioridad*/
    assign limit_ref = (i_sw[2:1] == 2'b00) ? R0:   //si es 0
                       (i_sw[2:1] == 2'b01) ? R1:   //sino, si es 1
                       (i_sw[2:1] == 2'b10) ? R2:R3;//sino, si es 2 y sino es 3

    /*procedural no bloqueante i quiero el rst asincrono se agrega con "or posedge rst"*/
    // acá siempre es reg <= lo que venga
    always @(posedge clk ) begin:procCounter
        if(i_reset) begin
            counter <= {NB_COUNT{1'b0}} //llenado con ceros
            valid <= 1'b0;
        end
        else if (i_sw[0]) begin
            
            if (counter < limit_ref) begin
                counter <= counter + 1;
                //counter <= counter + {{NB_COUNT-1{1'b0}},1'b1};
                valid <= 1'b0;
            end
            else begin
                counter <= 0;
                //counter <= {NB_COUNT{1'b0}}
                valid <= 1'b1;
            end

        end
        // podria no estar, pero es buena costumbre ponerlo
        else begin
            counter <= counter;
        end
    end

    /*logica de salida*/
    assign o_valid = valid;

endmodule //count
