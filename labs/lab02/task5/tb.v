`timescale 1ns/1ps

module tb;
  reg  [3:0] a, b;
  reg        op;
  wire [3:0] result;

  alu DUT (
    .a      (a),
    .b      (b),
    .op     (op),
    .result (result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer err = 0;
  reg [3:0] exp_res;

  initial begin
    a = 4'd5; b = 4'd3; op = 1'b0;
    #5;
    exp_res = (a + b) & 4'hF;
    if (result !== exp_res) begin
      $display("FAIL Add 5+3: got %0d expected %0d", result, exp_res);
      err = err + 1;
    end else begin
      $display("PASS Add 5+3: got %0d", result);
    end

    op = 1'b1;
    #5;
    exp_res = (a - b) & 4'hF;
    if (result !== exp_res) begin
      $display("FAIL Sub 5-3 (op toggle): got %0d expected %0d", result, exp_res);
      err = err + 1;
    end else begin
      $display("PASS Sub 5-3 (op toggle): got %0d", result);
    end

    a = 4'd8; b = 4'd2; op = 1'b1;
    #5;
    exp_res = (a - b) & 4'hF;
    if (result !== exp_res) begin
      $display("FAIL Sub 8-2: got %0d expected %0d", result, exp_res);
      err = err + 1;
    end else begin
      $display("PASS Sub 8-2: got %0d", result);
    end

    a = 4'd3; b = 4'd7; op = 1'b1;
    #5;
    exp_res = (a - b) & 4'hF;
    if (result !== exp_res) begin
      $display("FAIL Sub 3-7: got %0d expected %0d", result, exp_res);
      err = err + 1;
    end else begin
      $display("PASS Sub 3-7: got %0d", result);
    end

    if (err == 0)
      $display("ALL_ALU_TESTS_PASSED");
    else
      $display("ALU tests finished with %0d errors", err);

    #5 $finish;
  end

endmodule
