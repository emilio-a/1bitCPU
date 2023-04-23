-- implemento un shiftreg de 16 bits
-- con clr para poner todo en cero.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity shiftreg is
    Port (           
			  D   : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
			  Q : out STD_LOGIC_VECTOR(15 downto 0);
			  CLR : in  STD_LOGIC
			  );			  
end shiftreg;
    
architecture Behavioral of shiftreg is

    signal shift_reg : STD_LOGIC_VECTOR(15 downto 0);	-- := "0000000000000000";	--16 ceros por que tiene 16 bits, valor por default..hace falta?s
begin	

    process (CLK, CLR)
    begin
			if (CLR='1') then
				shift_reg <= x"0000";
			else
			  if (CLK'event and CLK = '1') then
					shift_reg(15) <= D;
					--shift_reg(15) <= shift_reg(16);
					shift_reg(14) <= shift_reg(15);
					shift_reg(13) <= shift_reg(14);
					shift_reg(12) <= shift_reg(13);
					shift_reg(11) <= shift_reg(12);
					shift_reg(10) <= shift_reg(11);
					shift_reg(9) <= shift_reg(10);
					shift_reg(8) <= shift_reg(9);
					shift_reg(7) <= shift_reg(8);
					shift_reg(6) <= shift_reg(7);
					shift_reg(5) <= shift_reg(6);
					shift_reg(4) <= shift_reg(5);
					shift_reg(3) <= shift_reg(4);
					shift_reg(2) <= shift_reg(3);
					shift_reg(1) <= shift_reg(2);
					shift_reg(0) <= shift_reg(1);
			  end if;
			end if;
    end process;
    
    -- hook up the shift register bits to the LEDs
    Q <= shift_reg;

end Behavioral;