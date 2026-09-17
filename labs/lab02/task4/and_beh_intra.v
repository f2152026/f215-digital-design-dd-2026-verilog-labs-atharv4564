// and_beh_intra.v
// 2-input AND gate with behavioral intra-assignment delay.

module and_beh_intra (
  input      a,
  input      b,
  output reg y
);

  always @(*) begin
    y = #5 (a & b);
  end

endmodule
