

// implemento un shiftreg de 16 bits
// con clr para poner todo en cero.
// no timescale needed

module shiftreg(
input wire D,
input wire CLK,
output wire [11:0] Q,
input wire CLR
);




reg [11:0] shift_reg;  // := "0000000000000000";	--16 ceros por que tiene 16 bits, valor por default..hace falta?s

  always @(posedge CLK, posedge CLR) begin
    if((CLR == 1'b1)) begin
      shift_reg <= 12'b000000000000;
    end else begin
      shift_reg[11] <= D;
      shift_reg[10] <= shift_reg[11];
      shift_reg[9] <= shift_reg[10];
      shift_reg[8] <= shift_reg[9];
      shift_reg[7] <= shift_reg[8];
      shift_reg[6] <= shift_reg[7];
      shift_reg[5] <= shift_reg[6];
      shift_reg[4] <= shift_reg[5];
      shift_reg[3] <= shift_reg[4];
      shift_reg[2] <= shift_reg[3];
      shift_reg[1] <= shift_reg[2];
      shift_reg[0] <= shift_reg[1];
    end
  end

  // hook up the shift register bits to the LEDs
  assign Q = shift_reg;

endmodule
