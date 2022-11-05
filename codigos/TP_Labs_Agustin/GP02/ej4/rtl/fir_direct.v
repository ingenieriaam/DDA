//! @title Semi-generic FIR filter
//! @author Agustin Matias Ortiz (aortiz@frba.utn.edu.ar)
//! @version 1.0
//! @date 01/11/2022
//!
//! @brief 4 TAPS FIR filter
//! @details Although it is strictly a 4-stage transposed FIR, it is described in 
//! such a way that it is easily scalable to more stages, however, the coefficients are imposed in the design. 
//!
//! ### utility site: 
//!
//! - https://chummersone.github.io/qformat.html 
//!
//! - http://t-filter.engineerjs.com/
//!
//! - http://www.fdi.ucm.es/profesor/mendias/das/docs/DAStema6.pdf
//!
//! - https://www.airsupplylab.com/verilog-fpga/83-fpga-lesson-04-verilog-scalar,-vector,-and-array.html#arrays
`define COCOTB_SIM 1

module fir_direct 
#(
    parameter NTAPS = 4                       //! Filter stages
) 
(
    output     signed [17:0] o_y            , //! Output signal

    input      signed [15:0] i_x            , //! Input signal 
    
    input            clk                    , //! Clock
    input            i_rst                    //! Asynchronous reset active low
    );
    //-----------arch-----------

    localparam  [15:0] zero    = {{16{1'b0}}} ;   //! Zeros 
    
    //! generics vars
    integer     idx=0                         ;   //! Index for generic processes
    reg signed  [15:0] i_h        [NTAPS-1:0] ;   //! Coefficients array
    reg signed  [15:0] FiltReg    [NTAPS-2:0] ;   //! Filter registers array
    reg signed  [31:0] Mult       [NTAPS-1:0] ;   //! Multiplier registers array
    wire signed [17:0] Sum        [NTAPS-2:0] ;   //! Adder results array
    
    //! simples vars
    wire signed [31:0] Temp_mul_0             ;   //! Auxiliary vector for clipping truncation of the multiplier 
    wire signed [31:0] Temp_mul_1             ;   //! Auxiliary vector for clipping truncation of the multiplier
    wire signed [31:0] Temp_mul_2             ;   //! Auxiliary vector for clipping truncation of the multiplier
    wire signed [31:0] Temp_mul_3             ;   //! Auxiliary vector for clipping truncation of the multiplier

    //! Hardcode coeff load to register
    always @(posedge i_rst) begin: Coefficient_load
        i_h[0]=16'h8000;
        i_h[1]=16'h8000;
        i_h[2]=16'h8000;
        /* i_h[1]=16'h46b6;
        i_h[2]=16'h46b6; */
        i_h[3]=16'h8000;     
    end

    //! Generic load of registers
    always @(posedge clk ) begin: Registers
        if(i_rst) begin
            for(idx=0; idx<NTAPS-1; idx=idx+1) begin
                FiltReg[idx] <= zero;
            end
        end 
        else begin
            FiltReg[0] <= i_x;
            for(idx=0; idx<NTAPS-2; idx=idx+1) begin
                FiltReg[idx+1] <= FiltReg[idx];
            end
        end
    end

    //! Generic multiplication
    always @(posedge clk ) begin:Multiplication 
        if(i_rst) begin
            for(idx=0; idx<NTAPS-1; idx=idx+1) begin
                Mult[idx] <=0;
            end
        end 
        else begin
            Mult[0] <= i_h[0]*i_x;
            for(idx=1; idx<NTAPS; idx=idx+1) begin
                Mult[idx] <= i_h[idx]*FiltReg[idx-1];
            end
        end
    end

    //! Addition
    assign Temp_mul_0   = Mult[0];
    assign Temp_mul_1   = Mult[1];
    assign Temp_mul_2   = Mult[2];
    assign Temp_mul_3   = Mult[3];
    assign Sum[0]       = {Temp_mul_0[30],Temp_mul_0[30],Temp_mul_0[30:15]};
    assign Sum[1]       = {Temp_mul_1[30],Temp_mul_1[30],Temp_mul_1[30:15]}+Sum[0];
    assign Sum[2]       = {Temp_mul_2[30],Temp_mul_2[30],Temp_mul_2[30:15]}+Sum[1];
    assign o_y          = {Temp_mul_3[30],Temp_mul_3[30],Temp_mul_3[30:15]}+Sum[2];
 
    /*===============*/
    /* for cocotb sim*/
    /*===============*/
    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("fir_direct.vcd");
    $dumpvars (0, fir_direct);
    #1;
    end
    `endif
endmodule