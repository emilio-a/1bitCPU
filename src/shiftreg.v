// File shiftreg.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
// vhd2vl settings:
//  * Verilog Module Declaration Style: 2001

// vhd2vl is Free (libre) Software:
//   Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd
//     http://www.ocean-logic.com
//   Modifications Copyright (C) 2006 Mark Gonzales - PMC Sierra Inc
//   Modifications (C) 2010 Shankar Giri
//   Modifications Copyright (C) 2002-2017 Larry Doolittle
//     http://doolittle.icarus.com/~larry/vhd2vl/
//   Modifications (C) 2017 Rodrigo A. Melo
//
//   vhd2vl comes with ABSOLUTELY NO WARRANTY.  Always check the resulting
//   Verilog for correctness, ideally with a formal verification tool.
//
//   You are welcome to redistribute vhd2vl under certain conditions.
//   See the license (GPLv2) file included with the source for details.

// The result of translation follows.  Its copyright status should be
// considered unchanged from the original VHDL.

// implemento un shiftreg de 16 bits
// con clr para poner todo en cero.
// no timescale needed

module shiftreg(
input wire D,
input wire CLK,
output wire [15:0] Q,
input wire CLR
);




reg [15:0] shift_reg;  // := "0000000000000000";	--16 ceros por que tiene 16 bits, valor por default..hace falta?s

  always @(posedge CLK, posedge CLR) begin
    if((CLR == 1'b1)) begin
      shift_reg <= 16'h0000;
    end else begin
      shift_reg[15] <= D;
      //shift_reg(15) <= shift_reg(16);
      shift_reg[14] <= shift_reg[15];
      shift_reg[13] <= shift_reg[14];
      shift_reg[12] <= shift_reg[13];
      shift_reg[11] <= shift_reg[12];
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
