module compuertasLogicas_tb;

  // Parameters

  // Ports
  reg   tb_ent1 = 0;
  reg   tb_ent2 = 0;
  reg   tb_ent3 = 0;
  reg   tb_act = 0;
  reg [2:0] tb_sel;
  wire sal;

  compuertasLogicas UUT 
  (
    .ent1 ( tb_ent1 ),
    .ent2 ( tb_ent2 ),
    .ent3 ( tb_ent3 ),
    .act  ( tb_act ),
    .sel  ( tb_sel ),
    .sal  ( sal )
  );

  initial begin
    tb_sel = 3'b000;
    tb_act = 1'b0;
    #10;
    $monitor("Sel: %b | Act: %b", tb_sel,tb_act);
    #10;
    tb_act = 1'b1;
    #10;
    tb_sel = 3'b001;
    
    repeat(6) begin
        #10;
        $monitor("Ent1: %b | Ent2: %b | Ent3: %b | Salida: %b", tb_ent1,tb_ent2,tb_ent3,sal);
        
        //--------
        tb_ent1=0;
        tb_ent2=0;
        tb_ent3=0;
        #10;
        //--------
        tb_ent1=0;
        tb_ent2=0;
        tb_ent3=1;
        #10;
        //--------
        tb_ent1=0;
        tb_ent2=1;
        tb_ent3=0;
        #10;
        //--------
        tb_ent1=0;
        tb_ent2=1;
        tb_ent3=1;
        #10;
        //--------
        tb_ent1=1;
        tb_ent2=0;
        tb_ent3=0;
        #10;
        //--------
        tb_ent1=1;
        tb_ent2=0;
        tb_ent3=1;
        #10;
        //--------
        tb_ent1=1;
        tb_ent2=1;
        tb_ent3=0;
        #10;
        //--------
        tb_ent1=1;
        tb_ent2=1;
        tb_ent3=1;
        #10;
        //--------
        tb_sel=tb_sel+1;
        #10;
    end
    $finish;

  end


endmodule
