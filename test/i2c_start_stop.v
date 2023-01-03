// i2c_start_stop
// example module to test the FSM concept for i2c start/stop condictions
//
//
module i2c_start_stop(
  input wire sda,
  input wire scl,
  input wire clk,
  input wire reset
);
  
  reg [7:0] data_frame_buf = 0;
  reg rw_buf = 0;
  reg [2:0] data_frame_count = 3'b000;
  localparam [1:0]  // fsm states
   fsm_wait = 2'b00,
   fsm_start1 = 2'b01,
   fsm_start = 2'b10,
   fsm_read = 2'b11;

   reg [1:0] i2c_state, i2c_state_next;

  always @(posedge clk, posedge reset) begin
    if (reset == 1) begin
      i2c_state = fsm_wait;
      i2c_state_next = fsm_wait;
      data_frame_count = 0;
    end
    else begin
      i2c_state = i2c_state_next;
    end
  end

  always @(i2c_state, scl, sda) begin
    case(i2c_state) 
      fsm_wait: 
        if ((!sda) && (scl)) begin
          i2c_state_next = fsm_start1;
        end
      fsm_start1:
        // sda pulled low and scl high
        if ((!sda) && (!scl)) begin
          i2c_state_next = fsm_start;
        end
      fsm_start: begin
        // scl pulled low after sda
        i2c_state_next = fsm_read;
        data_frame_count = 0;
      end
      fsm_read: begin
        // read address and r/w bit
        if (scl) begin
          if (data_frame_count < 3'b111) begin
          data_frame_buf[data_frame_count] = sda;
          data_frame_count = data_frame_count + 3'b1;
        //end else if ((scl) && (data_frame_count == 8)) begin
        //  rw_buf = sda;
        //  data_frame_count = data_frame_count + 1;
        //  i2c_state_next = i2c_state;
          end
        end
        i2c_state_next = i2c_state;
      end
      default:
        i2c_state_next = i2c_state;
    endcase

  end

endmodule
