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
  input wire [2:0] sel,
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
    if ( sel == 0 )
    begin
      sda_out0 <= sda_in;
      sda_out1 <= 0;
      sda_out2 <= 0;
      sda_out3 <= 0;
      sda_out4 <= 0;
      sda_out5 <= 0;
      sda_out6 <= 0;
      sda_out7 <= 0;
    end
    else if ( sel == 1 )
    begin
      sda_out0 <= 0;
      sda_out1 <= sda_in;
      sda_out2 <= 0;
      sda_out3 <= 0;
      sda_out4 <= 0;
      sda_out5 <= 0;
      sda_out6 <= 0;
      sda_out7 <= 0;
    end
    else if ( sel == 2 )
    begin
      sda_out0 <= 0;
      sda_out1 <= 0;
      sda_out2 <= sda_in;
      sda_out3 <= 0;
      sda_out4 <= 0;
      sda_out5 <= 0;
      sda_out6 <= 0;
      sda_out7 <= 0;
    end
    else if ( sel == 3 )
    begin
      sda_out0 <= 0;
      sda_out1 <= 0;
      sda_out2 <= 0;
      sda_out3 <= sda_in;
      sda_out4 <= 0;
      sda_out5 <= 0;
      sda_out6 <= 0;
      sda_out7 <= 0;
    end
    else if ( sel == 4 )
    begin
      sda_out0 <= 0;
      sda_out1 <= 0;
      sda_out2 <= 0;
      sda_out3 <= 0;
      sda_out4 <= sda_in;
      sda_out5 <= 0;
      sda_out6 <= 0;
      sda_out7 <= 0;
    end
    else if ( sel == 5 )
    begin
      sda_out0 <= 0;
      sda_out1 <= 0;
      sda_out2 <= 0;
      sda_out3 <= 0;
      sda_out4 <= 0;
      sda_out5 <= sda_in;
      sda_out6 <= 0;
      sda_out7 <= 0;
    end
    else if ( sel == 6 )
    begin
      sda_out0 <= 0;
      sda_out1 <= 0;
      sda_out2 <= 0;
      sda_out3 <= 0;
      sda_out4 <= 0;
      sda_out5 <= 0;
      sda_out6 <= sda_in;
      sda_out7 <= 0;
    end
    else if ( sel == 7 )
    begin
      sda_out0 <= 0;
      sda_out1 <= 0;
      sda_out2 <= 0;
      sda_out3 <= 0;
      sda_out4 <= 0;
      sda_out5 <= 0;
      sda_out6 <= 0;
      sda_out7 <= sda_in;
    end
    else   // should not happen
    begin
      sda_out0 <= 0;
      sda_out1 <= 0;
      sda_out2 <= 0;
      sda_out3 <= 0;
      sda_out4 <= 0;
      sda_out5 <= 0;
      sda_out6 <= 0;
      sda_out7 <= 0;
    end
  end

endmodule
