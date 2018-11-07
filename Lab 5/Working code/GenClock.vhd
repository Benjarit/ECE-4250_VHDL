library IEEE;
use IEEE.std_logic_1164.all;

entity GenClock is
Generic (time_period : integer range 1 to 4);
Port(clk: in std_logic;
	Clock: out std_logic);
end GenClock;

architecture Behavioral of GenClock is
signal clk_temp: std_logic :='0';
signal count: integer :=0;
begin
	process(clk,count)
	begin
	if (clk'event and clk ='1')then 
	case time_period is
		when 1 =>
		if (count = 25000000)then
			clk_temp<= not clk_temp;
			count<=0;
		else
			count<= count +1;
		end if;
		when 2 =>
		if (count = 50000000)then
			clk_temp<= not clk_temp;
			count<=0;
		else
			count<= count +1;
		end if;
		when 3 =>
		if (count = 100000000)then
			clk_temp<= not clk_temp;
			count<=0;
		else
			count<= count +1;
		end if;
		when 4 =>
		if (count = 200000000)then
			clk_temp<= not clk_temp;
			count<=0;
		else
			count<= count +1;
		end if;
	end case;
	end if;
	end process;
	clock  <= clk_temp;
end Behavioral;
