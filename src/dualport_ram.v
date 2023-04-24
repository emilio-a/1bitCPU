

// dual port ram de 256 bytes
//
// no timescale needed

module dualport_ram(
input wire [6:0] data_in_a,
input wire [6:0] data_in_b,
input wire rw_a,
input wire rw_b,
input wire clk,
input wire [4:0] address_a,
input wire [4:0] address_b,
output reg [6:0] data_out_a,
output reg [6:0] data_out_b
);





reg [6:0] memory_ram[0:31];

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
