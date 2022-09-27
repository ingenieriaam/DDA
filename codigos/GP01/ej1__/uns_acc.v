//! @title  Unsigned accumulator
//! @author Agustin Matias Ortiz (aortiz@frba.utn.edu.ar)
//! @version 1.0
//! @date 02/09/2022
//!
//! @brief Unsigned accumulator with adder input selection
//! @details Given the extension of the input word that the 
//! statement shows, it is assumed that it is an unsigned 
//! circuit and therefore it is appropriate to speak of Carry and not Overflow.
`define COCOTB_SIM 1

module uns_acc
(
    output reg [5:0] o_data , //! Acc output
    output           o_carry, //! Carry output

    input      [2:0] i_data2, //! Data imput
    input      [2:0] i_data1, //! Data imput
    input      [1:0] i_sel  , //! Input selection signal

    input            clk    , //! Clock
    input            i_rst_n  //! Asynchronous reset active low
);
//-----------arch-----------

    /*vars*/
    wire [3:0] ext_data1,ext_data2; //!word extention
    reg  [3:0] sel_out;             //!input MUX
    wire [6:0] adder_out;           //!next state adder output

    //!Mux of selection of the input data to accumulate
    always @(*) begin :input_selector
        case (i_sel)
            2'b00: 
                    sel_out = {1'b0,i_data2};
            2'b01: 
                    sel_out = i_data2 + i_data1;
            2'b10: 
                    sel_out = {1'b0,i_data1};
            2'b11: 
                    sel_out = {3{1'b0}};
            default: 
                    sel_out = {3{1'b0}};
        endcase
    end

    //!next state adder
    assign adder_out = o_data + {2'b00,sel_out};

    //!accumulator register
    always @(posedge clk or negedge i_rst_n) begin:accumulator
        if(! i_rst_n) begin
            o_data <= {5{1'b0}};
        end
        else begin 
            o_data <= adder_out[5:0];
        end
    end

    assign o_carry = adder_out[6];

    /*===============*/
    /* for cocotb sim*/
    /*===============*/
    `ifdef COCOTB_SIM
    initial begin
      $dumpfile ("uns_acc.vcd");
      $dumpvars (0, uns_acc);
      #1;
    end
    `endif

endmodule