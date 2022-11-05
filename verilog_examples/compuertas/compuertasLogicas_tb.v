module compuertasLogicas_tb;

  // Parameters

  // Ports
  reg   tb_ent1 = 0;
  reg   tb_ent2 = 0;
  reg   tb_ent3 = 0;
  reg   tb_act = 0;
  reg [2:0] tb_sel;
  wire sal;
  // signals
  reg [2:0] tb_ent;

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
    $dumpfile("/home/aortiz/DDA/verilog_tests/compuertas/compuertasLogicas.vcd"); 
    $dumpvars(0, compuertasLogicas_tb);
    tb_sel = 3'b000;
    tb_act = 1'b0;
    #10;
    $monitor("Sel: %b | Act: %b", tb_sel,tb_act);
    #10;
    tb_act = 1'b1;
    #10;
    tb_sel = 3'b001;
    tb_ent = 3'b000;
    
    repeat(6) begin
          #10;        
          repeat(8)begin
            {tb_ent1,tb_ent2,tb_ent3}=tb_ent;
            $monitor("Ent1: %b | Ent2: %b | Ent3: %b | Salida: %b", tb_ent1,tb_ent2,tb_ent3,sal);
            #20;
            tb_ent=tb_ent+1;
          end
          tb_sel=tb_sel+1;
          #10;
      end
      $finish;
  end

  always @(*) begin
    case(tb_sel)
      3'b001: begin
                $display("SEL = AND");
              end
      3'b010: $display("SEL = OR");
      3'b011: $display("SEL = XOR");
      3'b100: $display("SEL = NAND");
      3'b101: $display("SEL = NOR");
      3'b110: $display("SEL = XNOR");
      default: $display("SEL = OFF");
    endcase
  end


endmodule
