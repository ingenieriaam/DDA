//! @title  Differential equation
//! @author Agustin Matias Ortiz (aortiz@frba.utn.edu.ar)
//! @version 1.0
//! @date 02/09/2022
//!
//! @brief Ordinary differential equation
//! @details A circuit is implemented that performs the following 
//! differential equation:
//! y[n] = x[n] −x[n −1] + x[n −2] + x[n −3] + 0,5y[n −1] + 0,25y[n −2]
//! Rewriting to pool registers as delays (Y = Y(Z)):
//! -
//! ![eq](https://latex.codecogs.com/gif.latex?Y=X+Z^{-3}X+Z^{-2}(0.25Y+X)+.Z^{-1}(0.5Y-X\))


`define COCOTB_SIM 1
// Definitions
//`define N 16

module diffeq 
#(  // Parameters
    parameter N    = 16   //! Word lenght
)
(
    output reg signed [N-1:0] o_y   , //! output register

    input      signed [N-1:0] i_x   , //! Input signal

    input            clk    , //! Clock
    input            i_rst    //! Asynchronous reset active low
);

//-----------arch-----------

    /*vars*/
    reg signed [N:0] reg1,reg2,reg3;     //!unit delays

    //! Delays register with asynchronous reset
    always @(posedge clk or posedge i_rst) begin: Delays
        if(i_rst) begin
            reg1 <= {N{1'b0}};
            reg2 <= {N{1'b0}};
            reg3 <= {N{1'b0}};
            o_y  <= {N{1'b0}};
        end
        else begin 
            reg1 <= {1'b0,i_x};
            reg2 <= i_x + reg1 + (o_y >>> 2); //0.25 Y
            reg3 <= reg2 - i_x + (o_y >>> 2); //0.5
            o_y  <= i_x + reg3;
        end
    end

    /*===============*/
    /* for cocotb sim*/
    /*===============*/
    `ifdef COCOTB_SIM
    initial begin
    $dumpfile ("diffeq.vcd");
    $dumpvars (0, diffeq);
    #1;
    end
    `endif
endmodule