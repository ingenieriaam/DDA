//! @title Floating point multiplier
//! @author Agustin Matias Ortiz (aortiz@frba.utn.edu.ar)
//! @version 1.0
//! @date 24/09/2022
//!
//! @brief Unsigned accumulator with adder input selection
//! @details Multiplier of values whose format is: 
//!      
//! |bits    |  12  |  [11:8]  |   [7:0]  |
//! |---     |---   |---       |---       |
//! |function| Sign | Exponent | Mantissa |
//!      

`define COCOTB_SIM 1
`define bias 7

module fpmul 
(
    input  [12:0] i_data1, //! Data input
    input  [12:0] i_data2, //! Data input

    output reg [12:0] o_mul    //! Result
);
//-----------arch-----------

    // Localparam
    localparam  [12:0] nan         = {{6{1'b1}},{7{1'b0}}};     //! Nan representation
    localparam  [11:0] inf         = {{4{1'b1}},{8{1'b0}}};     //! Inf representation
    localparam  [11:0] zero        = {1'b0,{3{1'b1}},{8{1'b0}}};//! Zero representation

    /*vars*/
    wire Sign;                    //! Calculation of sign of result
    reg         [7:0]  Mantissa ; //! Truncation of multiplication
    wire        [15:0] Mult_res ; //! Res of multiplication only
    wire        [5:0]  Sum_exp  ; //! Sum of exponent - bias
    wire               Nan_check; //! Check if result must be NaN
    wire              Zero_check; //! Check if result must be zero

    //! Sign 
    assign Sign = i_data1[12] ^ i_data2[12];

    //! Mantissa
    assign Mult_res = i_data1[7:0] * i_data2[7:0]; // U(16.14)
    
    //! Truncation, U(8.7) with rounding
    always @(*) begin : trunc                      
        if (Mult_res[7]) Mantissa <= Mult_res[15:8]+1;
        else             Mantissa <= Mult_res[15:8];
    end

    //! Exponent
    assign Sum_exp   = i_data1[11:8] + i_data2[11:8] - `bias; 


    //! Nan check
    assign Nan_check = (i_data1==nan || i_data2==nan)              ? 1'b1 :
                       (i_data1[11:0]==inf && i_data2[11:0]==zero) ? 1'b1 :
                       (i_data2[11:0]==inf && i_data1[11:0]==zero) ? 1'b1 : 1'b0 ;
    //! Zero check
    assign Zero_check= (i_data1[11:0]==zero || i_data2[11:0]==zero) ? 1'b1 :
                       (i_data1[11:8] + i_data2[11:8] < `bias)      ? 1'b1 : 1'b0 ;



    //! General operation
    always @(*) begin : exp_calc   
        // not a number 
        if (Nan_check)              o_mul <= nan;
        // case zero
        else if (Zero_check)        o_mul <= {Sign,zero};         
        // normal operation
        else if (~Sum_exp[4])       o_mul <= {Sign,Sum_exp[3:0],Mantissa};
        // +- inf

        else if (Sum_exp[4])        o_mul <= {Sign,inf};

        else                        o_mul <= nan;

    end

    /*===============*/
    /* for cocotb sim*/
    /*===============*/
    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("fpmul.vcd");
    $dumpvars (0, fpmul);
    #1;
    end
    `endif

endmodule