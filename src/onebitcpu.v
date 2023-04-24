// File onebitcpu.vhd translated with vhd2vl v3.0 VHDL to Verilog RTL translator
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

// Topfile for 1bit CPU inspired in Rue Mohr's design
// Basically its a Moore finite state machine with the "next step logic" sinthetized in a RAM. In order to program that RAM
// and not having a brain meltdown, a dual-port ram is used and a single 16bit shift register.
// Intended to be submitted to the TinyTapeout III program 23/4/23
// V0.1 
// Entradas
// clk_shft, data_shft, wr_shft <- entradas de programacion
// clk_cpu <- clock de la cpu
// entradas (D1, D0)
// reset <- entrada general de reset, resetea el shift register y el reg de proximo estado. NO limpia la memoria
// Salidas
// salidas (Q1, Q0)
// files: dual_ram.vhd, shiftreg.vhd, reg8.vhd
// entidad 1bit CPU!
// no timescale needed

module onebitcpu(
input wire [7:0] io_in,
output wire [7:0] io_out
);




//entity onebitcpu is
//	port(
//		  clk_shft	:	in std_logic;	--clk del shiftreg
//		  data_shft	:	in std_logic;	--data del shiftreg
//		  wr_shft	:  in std_logic;	--con este bit escribo lo que entro por el shiftreg
//		  reset		:	in std_logic;	--reset general
//		  clk_cpu	:	in std_logic;
//		  entradas	:  in std_logic_vector(1 downto 0);
//		  salidas	:	out std_logic_vector(1 downto 0)
//			);
//end onebitcpu;
wire [15:0] bus_pgm;  // bus de programacion ue usare para programar la RAM
wire [15:0] bus_run;  // bus que correra el programa
wire [7:0] data_mem;  // bus datamem
wire [7:0] add_mem;
wire [7:0] data_out_a;
wire [7:0] data_in_b = 8'b00000000;  //valores por default
wire rw_b = 1'b0;  //valores por default
wire clk_shft;  //clk del shiftreg
wire data_shft;  //data del shiftreg
wire wr_shft;  //con este bit escribo lo que entro por el shiftreg
wire reset;  //reset general
wire clk_cpu;
wire [1:0] entradas;
wire [1:0] salidas;
wire [7:0] direcs_b;  //chanchada
// instancio un shiftreg que usare para programar la memoria
// instancio el registro de 8 bits
// instancio una dualport_ram

  // shift reg de programacion 
  shiftreg pgm_shiftreg(
      .D(data_shft),
    .CLK(clk_shft),
    .Q(bus_pgm),
    .CLR(reset));

  // registro de direcciones 
  reg8 reg_estado(
      .D(data_mem),
    .CLK(clk_cpu),
    .Q(add_mem),
    .CLR(reset));

  // memoria de "programa" (sintetizador de salidas, y proximo estado)	
  dualport_ram run_memory(
      .data_in_a(bus_pgm[7:0]),
    .data_in_b(data_in_b),
    .rw_a(wr_shft),
    .rw_b(rw_b),
    .clk(clk_cpu),
    .address_a(bus_pgm[15:8]),
    .address_b(direcs_b),
    //entradas(1 downto 0),
    .data_out_a(data_out_a),
    //aca debo ir a ningun lado
    .data_out_b(data_mem[7:0]));

  assign data_in_b = 8'b00000000;
  //no voy a escribir en el bus B de la memoria
  assign rw_b = 1'b0;
  //solo lectura
  //salidas (1 downto 0) <= add_mem(1 downto 0);	--asigno las salidas
  assign clk_shft = io_in[0];
  assign data_shft = io_in[1];
  assign wr_shft = io_in[2];
  assign reset = io_in[3];
  assign clk_cpu = io_in[4];
  //entradas    <= io_in(6 downto 5);
  assign io_out[1:0] = add_mem[1:0];
  assign io_out[7:2] = 6'b000000;
  assign direcs_b = {add_mem[7:2],io_in[6:5]};

endmodule
