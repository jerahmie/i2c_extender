// Testbench for i2c_extender 
`timescale 1 ns/10 ps
`include "../src/hdl/i2c_extender.v"

module i2c_exdenter_tb_top;
  reg scl_in;
  reg sda_in;
  reg scl_out;
  reg sda_out1;
  reg sda_out2;
  i2c_extender UUT(scl_in, sda_in, scl_out, sda_out1, sda_out2); 
  integer i;
  initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0, i2c_exdenter_tb_top);
    scl_in = 0;
    sda_in = 0;
    #10

    for (i=0; i<10; i++) begin 
      #10 scl_in = ~scl_in;
      $display("%0d, %0d", scl_in, scl_out);
    end
    end

    endmodule
