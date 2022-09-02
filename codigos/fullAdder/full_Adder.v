module full_adder (
    input      a,b,ci,
    input      sum,co    
);
//-----------arch-----------
// asignacion continua para logica combinacional
assign {co, sum} = a+b+ci;    

endmodule //full_adder
