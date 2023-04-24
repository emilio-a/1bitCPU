// File dualport_ram.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

// dual port ram de 256 bytes
//
// no timescale needed

module dualport_ram(
input wire [7:0] data_in_a,
input wire [7:0] data_in_b,
input wire rw_a,
input wire rw_b,
input wire clk,
input wire [7:0] address_a,
input wire [7:0] address_b,
output reg [7:0] data_out_a,
output reg [7:0] data_out_b
);





reg [7:0] memory_ram[0:255];

  always @(posedge clk) begin
    if(rw_a == 1'b1) begin
      memory_ram[address_a] <= data_in_a;
    end
    if(rw_b == 1'b1) begin
      memory_ram[address_b] <= data_in_b;
    end
    data_out_b <= memory_ram[address_b];
    data_out_a <= memory_ram[address_a];
  end


endmodule
