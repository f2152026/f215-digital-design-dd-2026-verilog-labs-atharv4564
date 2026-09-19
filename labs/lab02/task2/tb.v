// tb.v
// Testbench for lut with parameter override.

module tb;

  reg  [2:0] t_sel;
  wire [7:0] t_dout;

  // Parameter override: WIDTH=8, DEPTH=8
  lut #(.WIDTH(8), .DEPTH(8)) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer k;
  initial begin
    #1;
    for (k = 0; k < 8; k = k + 1) begin
      t_sel = k;
      #5;
    end
    #5 $finish;
  end

  initial
    $monitor($time, " sel=%0d | dout=%0d (hex: 0x%0h)", t_sel, t_dout, t_dout);

endmodule
