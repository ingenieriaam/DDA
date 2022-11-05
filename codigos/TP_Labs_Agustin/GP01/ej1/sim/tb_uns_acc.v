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
    tbclk = 1'b1;
    forever #1 tbclk = ~tbclk;
    end
    


// Test stimulus
  initial begin
    // Use the monitor task to display the FPGA IO
    $monitor("Init test stimulus");
    tbi_sel   = 2'b00 ;
    tbi_data1 = 3'b001;
    tbi_data2 = 3'b010;    
    tbi_rst_n = #10 1'b0;
    tbi_rst_n = 1'b1;
    $monitor("time=%3d, i_sel=%2b, i_data1=%d, i_data1=%d \n",$time, tbi_sel, tbi_data1, tbi_data2);
    // Generate each input with a 20 ns delay between them
    tbi_sel   = 2'b00 ;
    if (o_data != 'd20) begin
      $monitor("i_sel=%d :o_data should be 20, and was %d",tbi_sel,o_data);        
    end
    #20 
    //---------------------------
    $monitor("reset register"); 
    tbi_rst_n = 1'b0;
    #5
    tbi_sel   = 2'b01;
    tbi_rst_n = 1'b1;
    if (o_data != 'd30) begin
        $monitor("i_sel=%d :o_data should be 10, and was %d",tbi_sel,o_data);        
    end
    //---------------------------
    $monitor("reset register"); 
    tbi_rst_n = 1'b0;
    #5
    tbi_sel   = 2'b01;
    tbi_rst_n = 1'b1;
    if (o_data != 'd10) begin
        $monitor("i_sel=%d :o_data should be 30, and was %d",tbi_sel,o_data);        
    end
    tbi_sel   = #20 2'b11 ;
    if (o_data != 'd10) begin
        $monitor("i_sel=%d :o_data should be 33, and was %d",tbi_sel,o_data);        
    end
    
    $monitor("End test");
end
endmodule