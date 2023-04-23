-- dual port ram de 256 bytes
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity dualport_ram is
	Port (
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
end dualport_ram;

architecture Behavioral of dualport_ram is

type ramtype is array(0 to 255) of std_logic_vector(7 downto 0);    

signal memory_ram : ramtype;

begin                                                        

input_a : process (clk)                                                
begin                                                        
	if rising_edge(clk) then  
		if rw_a = '1' then                                             
			memory_ram(to_integer(unsigned(address_a))) <= data_in_a;
      end if;
		if rw_b = '1' then
			memory_ram(to_integer(unsigned(address_b))) <= data_in_b;
		end if;
		data_out_b <= memory_ram(to_integer(unsigned(address_b)));
		data_out_a <= memory_ram(to_integer(unsigned(address_a)));
	end if;		
end process;             

end Behavioral;