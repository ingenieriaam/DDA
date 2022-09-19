/*Modulo Compuertas Logicas 
Selector Funciones Logicas: AND, OR, XOR, NAND, NOR, XNOR 
Señal Activacion 
3 Entrada! Asincrona 
**/

module compuertasLogicas
(
    input wire ent1, ent2, ent3, 
    input wire act,
    input wire [2:0]sel, 
    output reg sal 
); 
always@(*)begin 
    sal =   (sel == 3'b001) ?  ( ent1 & ent2 & ent3 ): //AND 
            (sel == 3'b010) ?  ( ent1 | ent2 | ent3 ): //OR 
            (sel == 3'b011) ?  ( ent1 ^ ent2 ^ ent3 ): //XOR 
            (sel == 3'b100) ? !( ent1 & ent2 & ent3 ): //NAND 
            (sel == 3'b101) ? !( ent1 | ent2 | ent3 ): //NOR 
            (sel == 3'b110) ? !( ent1 ^ ent2 ^ ent3 ): //XNOR 
                                               (1'b0); //Default 
end

endmodule