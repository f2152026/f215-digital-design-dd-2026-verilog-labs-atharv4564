// tb.v
// Self-checking testbench for 2-bit comparator comp2.

`timescale 1ns/1ps

module tb;
  reg  [1:0] A, B;
  wire       GT, LT, EQ;

  comp2 DUT (
    .A  (A),
    .B  (B),
    .GT (GT),
    .LT (LT),
    .EQ (EQ)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer i, j, errors, total;
  reg exp_gt, exp_lt, exp_eq;

  initial begin
    errors = 0;
    total = 0;
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        A = i[1:0];
        B = j[1:0];
        exp_gt = (i > j);
        exp_lt = (i < j);
        exp_eq = (i == j);
        #5;
        total = total + 1;
        if ({GT, LT, EQ} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, A, B, GT, LT, EQ, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    if (errors == 0)
      $display("ALL_COMP2_TESTS_PASSED: %0d/%0d tests passed.", total, total);
    else
      $display("SUMMARY: %0d failed out of %0d tests.", errors, total);
    $finish;
  end

endmodule
