-- registro de 8 bit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity reg8 is 
	port(
    D   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    CLK : IN STD_LOGIC; -- clock.
    Q   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Q
	 CLR : IN STD_LOGIC -- clear.
	);
END reg8;


ARCHITECTURE descripcion OF reg8 IS
BEGIN
    process(CLK, CLR)
    begin
        if CLR = '1' then
            Q <= x"00";
        elsif rising_edge(CLK) then
                Q <= D;
        end if;
    end process;
END descripcion;