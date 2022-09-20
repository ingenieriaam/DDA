module top
#(
    parameter    NB_SW      4,
    parameter    NB_COUNT   32,
    parameter    NB_LEDS    4
) 
(
    // outputs
    output  [NB_LEDS-1:0] o_led  ,
    output  [NB_LEDS-1:0] o_led_b,
    output  [NB_LEDS-1:0] o_led_g,
    // inputs
    input   [NB_LEDS-1:0] i_sw   ,
    input   i_clk        ,
    input   i_rst    
);

//-----------arch-----------

wire connect_count2sr_valid;
wire [NB_COUNT-1 : 0] leds_w;

    count
    #(
        .NB_SW      (NB_SW),
        .NB_COUNT   (NB_COUNT)
    )
    u_count(
        .o_valid(connect_count2sr_valid),
        .i_sw(i_sw[2:0]),
        .clk(i_clk),
        .i_rst(~i_rst)
    )

    shiftreg
    #(
        .NB_LEDS     (NB_LEDS)
    )
    u_shiftreg(
        .o_led(leds_w),
        .i_valid(connect_count2sr_valid),
        .i_rst(~i_rst),
        .clk(i_clk)
    )

    assign o_led = leds_w;
    assign o_led_b = (i_sw[NB_SW-1]==1'b1) ? leds_w _ 4'b000;
    assign o_led_g = (i_sw[NB_SW-1]==1'b0) ? leds_w _ 4'b000;

endmodule //top
