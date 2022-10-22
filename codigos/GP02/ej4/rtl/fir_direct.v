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
    reg signed [15:0] i_h [NTAPS-1:0] ; 
    reg [15:0] FiltReg    [NTAPS-2:0] ;
    reg [31:0] Mult       [NTAPS-1:0] ;
    reg [17:0] Sum        [NTAPS-1:0] ;
    reg signed [31:0] Mult_aux        ;

    /*b = np.array([0,0,0,1])
    a = np.array([1,-0.5,0.25,0.5])*/
    //! Hardcode coeff
    always @(negedge i_rst) begin: coefficient_load
        i_h[0]=16'h001e;
        i_h[1]=16'h46b6;
        i_h[2]=16'h46b6;
        i_h[3]=16'h001e;     
    end

    //! Performs a N taps filter
    always @(posedge clk ) begin: registers
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
    //! Addition and multiplication
    always @(posedge clk ) begin
        if(i_rst) begin
            for(idx=1; idx<NTAPS-1; idx=idx+1) begin
                Mult[idx] <={32'b0};
                Sum [idx] <={18'b0};
            end
            Mult_aux <={32'b0};
        end 
        else begin
            Mult[0] <= i_h[0]*i_x;
            Sum [0] <= Mult[0]; 
            for(idx=1; idx<NTAPS; idx=idx+1) begin
                Mult[idx] <= i_h[idx]*FiltReg[idx-1];
                Mult_aux  =  Mult[idx];
                Sum [idx] <= Mult[idx][30:15]+Mult[idx-1][30:15];
            end
        end
    end
    assign o_y = Mult_aux;

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