// i2c_extender module
//
//      +----------------------+
//    --| scl_in      sda_out0 |--
//    --| sda_in      scl_out0 |--
//      |                      |
//      |             sda_out1 |--
//      |             scl_out1 |--
//      +----------------------+
//
  module i2c_extender (
  input wire scl_in,
  input wire sda_in,
  output reg scl_out,
  output reg sda_out0,
  output reg sda_out1,
  output reg sda_out2,
  output reg sda_out3,
  output reg sda_out4,
  output reg sda_out5,
  output reg sda_out6,
  output reg sda_out7
);

  always @(scl_in) begin
    scl_out <= scl_in;
  end

endmodule
