// utility site: https://chummersone.github.io/qformat.html
//               http://t-filter.engineerjs.com/
//               http://www.fdi.ucm.es/profesor/mendias/das/docs/DAStema6.pdf
//               https://www.airsupplylab.com/verilog-fpga/83-fpga-lesson-04-verilog-scalar,-vector,-and-array.html#arrays
`define COCOTB_SIM 1

module fir_direct 
#(
    parameter NTAPS = 4
) 
(
    output     signed [17:0] o_y            , //! output register

    input      signed [15:0] i_x            , //! Input signal 
    
    input            clk                    , //! Clock
    input            i_rst                    //! Asynchronous reset active low
    );
    //-----------arch-----------

    localparam  [15:0] zero        = {{16{1'b0}}};//! Zeros 
    localparam  [15:0] ones        = {{16{1'b1}}};//! Ones
    
    /*vars*/
    integer idx=0;
    reg signed [15:0] i_h        [NTAPS-1:0] ; 
    reg signed [15:0] FiltReg    [NTAPS-2:0] ;
    reg signed [31:0] Mult       [NTAPS-1:0] ;
    wire signed [17:0] Sum        [NTAPS-2:0] ;

    wire signed [31:0] Temp_mul_0      ;
    wire signed [31:0] Temp_mul_1      ;
    wire signed [31:0] Temp_mul_2      ;
    wire signed [31:0] Temp_mul_3      ;

    //! Hardcode coeff
    always @(posedge i_rst) begin: Coefficient_load
        i_h[0]=16'h8000;
        i_h[1]=16'h8000;
        i_h[2]=16'h8000;
        /* i_h[1]=16'h46b6;
        i_h[2]=16'h46b6; */
        i_h[3]=16'h8000;     
    end

    //! Performs a N taps filter
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

    //! Multiplication
    always @(posedge clk ) begin:Multiplication // it's ok
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