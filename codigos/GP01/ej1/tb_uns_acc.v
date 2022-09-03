`timescale 10ns / 1ps

module uns_acc_tb;

  // Parameters

  // test Ports
  wire [5:0] o_data;
  wire o_carry;
  reg [2:0] tbi_data2;
  reg [2:0] tbi_data1;
  reg [1:0] tbi_sel;
  reg tbclk = 0;
  reg tbi_rst_n = 0;

  uns_acc 
  uns_acc_dut (
    .o_data     (o_data    ),
    .o_carry    (o_carry   ),
    .i_data2    (tbi_data2 ),
    .i_data1    (tbi_data1 ),
    .i_sel      (tbi_sel   ),
    .clk        (tbclk     ),
    .i_rst_n    ( tbi_rst_n)
  );

    // generate the clock
    initial begin
    tbclk = 1'b0;
    forever #1 tbclk = ~tbclk;
    end
    
    // Generate the reset
    initial begin
        tbi_rst_n = 1'b0;
        #10
        tbi_rst_n = 1'b1;
    end


// Test stimulus
  initial begin
    // Use the monitor task to display the FPGA IO
    $monitor("Init test stimulus");
    tbi_data1 = 3'b001;
    tbi_data2 = 3'b010;
    $monitor("time=%3d, i_sel=%2b, i_data1=%3b, i_data1=%3b \n",$time, tbi_sel, tbi_data1, tbi_data2);
    // Generate each input with a 20 ns delay between them
    tbi_sel   = 2'b00 ;
    #10
    if (o_data != 'd20) begin
        $monitor("o_data should be 40, and was %d",o_data);        
    end
    //---------------------------
    $monitor("reset register"); 
    tbi_rst_n = 1'b0;
    #10
    tbi_rst_n = 1'b1;
    tbi_sel   = 2'b01 ;
    #10
    if (o_data != 'd30) begin
        $monitor("o_data should be 40, and was %d",o_data);        
    end
    //---------------------------
    $monitor("reset register"); 
    tbi_rst_n = 1'b0;
    #10
    tbi_rst_n = 1'b1;
    tbi_sel   = 2'b10 ;
    #10
    if (o_data != 'd10) begin
        $monitor("o_data should be 40, and was %d",o_data);        
    end
    tbi_sel   = 2'b11 ;
    #20
    if (o_data != 'd10) begin
        $monitor("o_data should be 40, and was %d",o_data);        
    end
    
    $monitor("End test");
end
endmodule