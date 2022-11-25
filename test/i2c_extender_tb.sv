// Testbench for i2c_extender 
`timescale 1 ns/10 ps
`include "../src/hdl/i2c_extender.v"

module i2c_exdenter_tb_top;
  reg scl_in;
  reg sda_in;
  reg [2:0] sel; 
  reg scl_out;
  reg sda_out1;
  reg sda_out2;
  reg sda_out3;
  reg sda_out4;
  reg sda_out5;
  reg sda_out6;
  reg sda_out7;
  reg sda_out8;

  i2c_extender UUT(scl_in, sda_in, sel, scl_out, sda_out1, sda_out2,
                   sda_out3, sda_out4, sda_out5, sda_out6, 
                   sda_out7, sda_out8); 
  integer i;
  initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0, i2c_exdenter_tb_top);
    scl_in = 0;
    sda_in = 0;
    sel = 0; 
    #10

    for (i=0; i<10; i++) begin 
      #10 scl_in = ~scl_in;
      $display("%0d, %0d", scl_in, scl_out);
    end
    end

    endmodule
