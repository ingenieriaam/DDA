//! @title Floating point multiplier
//! @author Agustin Matias Ortiz (aortiz@frba.utn.edu.ar)
//! @version 1.0
//! @date 24/09/2022
//!
//! @brief Unsigned accumulator with adder input selection
//! @details Multiplier of values whose format is: 
//!      +------+----------+----------+
//! bit  |  12  |  [11:8]  |   [7:0]  |
//!      +------+----------+----------+
//! data | Sign | Exponent | Mantissa |
//!      +------+----------+----------+

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
    localparam  [7:0]  mant_zero   = {8{1'b0}};
    localparam  [3:0]  exp_ones    = {4{1'b1}};
    localparam  [13:0] nan_const   = {{6{1'b1}},{7{1'b0}}};
    localparam  [13:0] zeroN_const = {{1'b1},{10{1'b0}}};
    localparam  [13:0] zeroP_const = {{1'b0},{10{1'b0}}};
    localparam  [13:0] infN_const  = {{1'b1},exp_ones,mant_zero};
    localparam  [13:0] infP_const  = {{1'b0},exp_ones,mant_zero};

    /*vars*/
    wire Sign;
    reg         [3:0]  Exponent ;
    reg         [7:0]  Mantissa ;
    wire        [15:0] Mult_res ;
    wire signed [6:0]  Sum_exp  ;
    wire               Nan_check;
    wire               Singular_val1;
    wire               Singular_val2;

    //! Sign 
    assign sign = i_data1[12] ~^ i_data2[12];

    //! Mantissa
    assign Mult_res = i_data1[7:0] * i_data2[7:0]; //! U(16.14)

    always @(*) begin : trunc                      //! U(8.7) with rounding
        if (Mult_res[7]) begin
            Mantissa <= Mult_res[15:8]+1;
        end
        else begin
            Mantissa <= Mult_res[15:8];
        end
    end

    //! Exponent
    assign Sum_exp = i_data1[11:8] + i_data2[11:8] + `bias + 1; 

    //! Nan check
    //! check if data1 is one of the problematic values
    assign Singular_val1 =  (i_data1==zeroN_const || i_data1==zeroP_const) ? 1'b1 :  
                            (i_data1==infN_const  || i_data1==infP_const ) ? 1'b1 :
                            (i_data1==nan_const )                   ? 1'b1 : 1'b0 ;
    //! check if data2 is one of the problematic values
    assign Singular_val2 =  (i_data2==zeroN_const || i_data2==zeroP_const) ? 1'b1 :  
                            (i_data2==infN_const  || i_data2==infP_const ) ? 1'b1 :
                            (i_data2==nan_const )                   ? 1'b1 : 1'b0 ;
    //! if both are problematic, it cannot be operated and the NaN indicator is generated
    assign Nan_check     =  (Singular_val1 && Singular_val2)        ? 1'b1 : 1'b0 ;
    
    always @(*) begin : exp_calc   
        // not a number 
        if (Nan_check) begin                      
            o_mul    <= nan_const;
        end               
        // normal operation
        else if (Sum_exp<6'b001111) begin 
            Exponent = Sum_exp[3:0];
            o_mul    <= {Sign,Exponent,Mantissa};
        end
        // +- inf
        else begin                  
            o_mul    <= {Sign,exp_ones,mant_zero};
        end
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