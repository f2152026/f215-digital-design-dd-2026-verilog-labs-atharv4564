// and_df.v
// 2-input AND gate with dataflow continuous assignment delay.

module and_df (
  input  a,
  input  b,
  output y
);

  assign #5 y = a & b;

endmodule
