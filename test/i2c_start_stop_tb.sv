// Testbench for i2c start and state machine
//
`timescale 1 ns/10ps
`include "i2c_start_stop.v"

module i2c_start_stop_tb_top;
  reg scl = 1;
  reg sda = 1;
  reg clk = 0;
  reg reset = 0;

i2c_start_stop UUT(sda, scl, clk, reset);
   
  // system clock
  initial begin
    forever begin
      #10 clk = ~clk;
    end
  end

  integer i;
  initial begin
    $dumpfile("i2c_start_stop.vcd");
    $dumpvars(0, i2c_start_stop_tb_top, UUT);
    #10 reset = 1;
    #10 reset = 0; 
    #10 sda = 0;
    #10 scl = 0;
    #10 sda = 1;
    #10 scl = 1; 
    #10 sda = 0;
    #10 scl = 0;
    #10 sda = 1;
    #10 scl = 1;
    #10 scl = 0;
    #10 scl = 1; 
    #10 scl = 0;
    #10 scl = 1;
    #10 scl = 0;
    #10 scl = 1;
    #10 scl = 0;
    #100 $finish;
  end

endmodule
