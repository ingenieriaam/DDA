`define COCOTB_SIM 1

module full_adder
  (
    input      a,b,ci,
    output     sum,co
  );
  //-----------arch-----------
  // the "macro" to dump signals
  assign {co, sum} = a+b+ci;

  // Only for cocotb simulation waveforms
  `ifdef COCOTB_SIM
    initial begin
      $dumpfile ("full_adder.vcd");
      $dumpvars (0, full_adder);
      #1;
    end
  `endif

endmodule //full_adder
