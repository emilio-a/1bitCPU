
// registro de 8 bit
// no timescale needed

module reg8(
input wire [6:0] D,
input wire CLK,
output reg [6:0] Q,
input wire CLR
);

// clock.
// Q
// clear.




  always @(posedge CLK, posedge CLR) begin
    if(CLR == 1'b1) begin
      Q <= 7'b0000000;
    end else begin
      Q <= D;
    end
  end


endmodule
