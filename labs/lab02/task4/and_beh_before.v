// and_beh_before.v
// 2-input AND gate with behavioral delay placed before assignment.

module and_beh_before (
  input      a,
  input      b,
  output reg y
);

  always @(*) begin
    #5 y = a & b;
  end

endmodule
