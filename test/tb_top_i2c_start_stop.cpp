#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vi2c_start_stop.h"

#define MAX_SIM_TIME 500
vluint64_t sim_time = 0;

// i2c_start condition
//
void i2c_start(const int posedge_count, Vi2c_start_stop* dut) {
  static int count = 0;
  dut->sda = 0;
  if (count < 10) {
    count++;
  }
  else
  {
    count = 0;
    dut->scl = 0;
  }
}
void i2c_send_data(const int data, Vi2c_start_stop* dut) {
  std::cout << "i2c_send_data\n";
  static int data_count = 1;
  std::cout << "data_count: " << data_count << '\n';
  if (dut->scl == 1) {
    if (data_count <= 128) {
      dut->sda = (data & data_count)? 1: 0;
      data_count*=2;
      std::cout << "data_count, sda: " << data_count << ',' << dut->sda << '\n';
    } else {
      data_count = 1;
   }
  }  
}

int main(int argc, char** argv, char **env)
{ 
  std::cout << "Initializing DUT...\n";
  Vi2c_start_stop *dut = new Vi2c_start_stop;
  
  Verilated::traceEverOn(true);
  VerilatedVcdC *m_trace = new VerilatedVcdC;
  dut->trace(m_trace, 5);
  m_trace->open("waveform.vcd");

  // initialize testbench variables
  long posedge_count = 0;
  int data = 0b01101011;
  // some devices addresses
  int address1 = 0x65; 
  int address2 = 0x66;
  int address3 = 0x67; // 0b1100111
  dut->reset = 0;
  dut->clk = 0;
  dut->scl = 0;
  dut->sda = 0;  // sda is inout

  while (sim_time < MAX_SIM_TIME) {
    dut->clk ^= 1;
    if (dut->clk == 1) {
      posedge_count++;
    }
    if (posedge_count == 10) {
      dut->reset = 1;
      dut->scl = 1;
      dut->sda = 1;
    }
    if (posedge_count == 20) {
      dut->reset = 0;
    }
    if (posedge_count >= 40 and posedge_count < 50) {
      i2c_start(posedge_count, dut);
    }
    if (posedge_count >= 60 and posedge_count < 220) {
      if ((posedge_count % 10 == 0) and (dut->clk == 1)) {
        dut->scl ^= 1;
        i2c_send_data(address3+0x80, dut);  
      }
    }
    dut->eval();
    m_trace->dump(sim_time);
    sim_time++;
  }
  std::cout << "address3: " << address3 << '\n';
  std::cout << "address3 << 1 + 1: " << std::hex << (address3 << 1) + 1 << '\n';
  std::cout << "Cleaning up...\n";
  m_trace->close();
  delete dut;
  std::cout << "Done.\n";
  exit(EXIT_SUCCESS);
}
