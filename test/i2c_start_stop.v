// i2c_start_stop
// example module to test the FSM concept for i2c start/stop condictions
//

//`define TRISTATE_SUPPORT 

`ifdef  TRISTATE_SUPPORT
  `define HIGHZ 1'bz
`else
  `define HIGHZ 1'b1  // change to 1'bZ for implementation
`endif

module i2c_start_stop(
  inout sda,
  input wire scl,
  input wire clk, input wire reset);

 reg sda_oe;
 reg sda_out;
 reg sda_in;

  assign sda  = (sda_oe) ? sda_out: `HIGHZ;
  //assign sda_oe = 0;
  assign sda_out = 1;
  assign sda_in = sda;

  reg [7:0] data_frame_buf;
  reg [2:0] data_frame_count;
  localparam [3:0]  // fsm states
   fsm_wait = 4'b0000,
   fsm_start1 = 4'b0001,
   fsm_start = 4'b0010,
   fsm_read = 4'b0011,
   fsm_read_wait = 4'b0100,
   fsm_ack1 = 4'b0101,
   fsm_ack2 = 4'b0110;


   reg [2:0] i2c_state, i2c_state_next;

  always @(posedge clk, posedge reset) begin
    if (reset == 1) begin
      i2c_state <= fsm_wait;
      i2c_state_next <= fsm_wait;
      data_frame_count <= 3'b000;
      sda_oe <= 1'b0;
    end
    else begin
      case(i2c_state) 
       fsm_wait: begin
          if ((!sda) && (scl)) begin
             i2c_state_next <= fsm_start1;
          end
         end // fsm_wait
       fsm_start1: begin
        // sda pulled low and scl high
         if (sda) begin
           i2c_state_next <= fsm_wait;
         end
         if ((!sda) && (!scl)) begin
            i2c_state_next <= fsm_start;
         end
       end // fsm_start1
       fsm_start: begin
        // scl pulled low after sda
        i2c_state_next <= fsm_read;
        //data_frame_count <= 3'b000;
       end // fsm_start
       fsm_read: begin
        // read address and r/w bit
        if (scl) begin
          if ((i2c_state == fsm_read) && (i2c_state_next == fsm_read_wait)) begin
            data_frame_count <= data_frame_count + 3'b001;
          end
          if (data_frame_count == 3'b111) begin
            i2c_state_next <= fsm_ack1;
          end else begin
            data_frame_buf[data_frame_count] <= sda;
            i2c_state_next <= fsm_read_wait;
          end
        end 
      end // fsm_read
      fsm_read_wait: begin
        if (!scl) begin
          i2c_state_next <= fsm_read;
        end
      end // fsm_read_wait
      fsm_ack1: begin
        sda_oe <= 1'b1;
        i2c_state_next <= fsm_ack2;
      end // fsm_ack1
      fsm_ack2: begin
        sda_out <= 1'b1;
        i2c_state_next <= i2c_state; // hold at current state
      end // i2c_ack2
      default:
        i2c_state_next <= i2c_state;
    endcase
    i2c_state <= i2c_state_next;
  end
//
  end // always(..)

endmodule
