// Testbench for i2c_extender 
//

class transaction;
  // declaring transaction items
  bit scl;
  bit sda;

function void display(string name);
  $display("----------------------------");
  $display("- %s", name);
  $display("----------------------------");
  $display("- scl = %0d, sda = %0d", scl, sda);
  $display("----------------------------");
endfunction
endclass
