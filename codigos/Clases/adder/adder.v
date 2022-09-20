module adder 
(
    input      [3:0]i_a,
    input      [3:0]i_b,
    input      [4:0]o_sum
);
//-----------arch-----------
assign o_sum = i_a + i_b;
    
endmodule //adder
