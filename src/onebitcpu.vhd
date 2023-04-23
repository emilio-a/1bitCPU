-- Topfile for 1bit CPU inspired in Rue Mohr's design
-- Basically its a Moore finite state machine with the "next step logic" sinthetized in a RAM. In order to program that RAM
-- and not having a brain meltdown, a dual-port ram is used and a single 16bit shift register.
-- Intended to be submitted to the TinyTapeout III program 23/4/23

-- V0.1 

-- Entradas
-- clk_shft, data_shft, wr_shft <- entradas de programacion
-- clk_cpu <- clock de la cpu
-- entradas (D1, D0)
-- reset <- entrada general de reset, resetea el shift register y el reg de proximo estado. NO limpia la memoria

-- Salidas
-- salidas (Q1, Q0)

-- files: dual_ram.vhd, shiftreg.vhd, reg8.vhd

library ieee;
use ieee.std_logic_1164.all;


-- entidad 1bit CPU!
entity onebitcpu is
	port(
		  clk_shft	:	in std_logic;	--clk del shiftreg
		  data_shft	:	in std_logic;	--data del shiftreg
		  wr_shft	:  in std_logic;	--con este bit escribo lo que entro por el shiftreg
		  reset		:	in std_logic;	--reset general
		  clk_cpu	:	in std_logic;
		  entradas	:  in std_logic_vector(1 downto 0);
		  salidas	:	out std_logic_vector(1 downto 0)
			);
end onebitcpu;
	
	
Architecture arquitectura of onebitcpu is

	signal bus_pgm	:   std_logic_vector(15 downto 0);	-- bus de programacion ue usare para programar la RAM
	signal bus_run	:	 std_logic_vector(15 downto 0);	-- bus que correra el programa
	signal data_mem :  std_logic_vector (7 downto 0);  -- bus datamem
	signal add_mem :   std_logic_vector (7 downto 0);
	signal data_out_a : std_logic_vector(7 downto 0);
	signal data_in_b : std_logic_vector(7 downto 0) := "00000000";	--valores por default
	signal rw_b : 		 std_logic := '0';											--valores por default
	

-- instancio un shiftreg que usare para programar la memoria
component shiftreg is	  
port(		
		D	 : in std_logic;
		CLK : in std_logic;
		Q	 : out std_logic_vector (15 downto 0);
		CLR : in std_logic
		);
end component;

-- instancio el registro de 8 bits
component reg8 is	  
port(
		D	 : in std_logic_vector (7 downto 0);
		CLK : in std_logic;
		Q	 : out std_logic_vector (7 downto 0);		
		CLR : in std_logic
		);
end component;

-- instancio una dualport_ram
component dualport_ram is
port (
		data_in_a : in STD_LOGIC_VECTOR(7 downto 0);
		data_in_b : in STD_LOGIC_VECTOR(7 downto 0);
		rw_a : in STD_LOGIC;
		rw_b : in STD_LOGIC;
		clk : in STD_LOGIC;
		address_a : in STD_LOGIC_VECTOR(7 downto 0);
		address_b : in STD_LOGIC_VECTOR(7 downto 0);
		data_out_a : out STD_LOGIC_VECTOR(7 downto 0);
		data_out_b : out STD_LOGIC_VECTOR(7 downto 0)		
		);
end component;


	begin
	
-- shift reg de programacion 
	pgm_shiftreg: shiftreg 	port map(
			D => data_shft,
			CLK => clk_shft,
			Q => bus_pgm,
			CLR => reset
		);

-- registro de direcciones 
	reg_estado: reg8 port map(
			D => data_mem,
			CLK => clk_cpu,
			Q => add_mem,
			CLR => reset			
		);
		
-- memoria de "programa" (sintetizador de salidas, y proximo estado)	
	run_memory: dualport_ram port map(
			data_in_a => bus_pgm(7 downto 0),
			data_in_b => data_in_b, 
			rw_a		 => wr_shft,
			rw_b		 => rw_b,
			clk 		 => clk_cpu,
			address_a => bus_pgm(15 downto 8),
			address_b => add_mem ( 7 downto 2) & entradas(1 downto 0),
			data_out_a=> data_out_a,--aca debo ir a ningun lado
			data_out_b=> data_mem (7 downto 0)			
		);
		
	
data_in_b <= "00000000";	--no voy a escribir en el bus B de la memoria
rw_b 	<= '0';					--solo lectura
	
salidas (1 downto 0) <= add_mem(1 downto 0);	--asigno las salidas


end arquitectura;