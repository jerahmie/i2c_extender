// i2c_extender module
//
//
module i2c_extender (
  input wire scl_in,
  input wire sda_in,
  output reg scl_out,
  output reg sda_out1,
  output reg sda_out2
);

  reg [0:7] data_buf [0:2];
  

  always @(scl_in) begin
    scl_out = scl_in;
    sda_out1 = sda_in;
    sda_out2 = 0;
  end

endmodule
