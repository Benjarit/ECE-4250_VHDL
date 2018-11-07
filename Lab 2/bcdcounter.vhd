

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_bit.all;

entity BCDcounter is
	port(ENABLE, LOAD, UP, CLR, CLK: IN BIT;
		D: IN unsigned(3 DOWNTO 0);
		Q: INOUT unsigned(3 DOWNTO 0);
		Cout: OUT BIT);
end BCDcounter;

Architecture behav of BCDcounter is

signal Qint: unsigned(3 downto 0);
begin
	process(CLK,CLR)
	begin
	if CLR = '0' then Q <= "0000";
		elsif (CLK' event and ClK = '1') then
		if (LOAD = '1' and ENABLE = '1') then Qint <= D;
			elsif (ENABLE = '1' and UP = '1' and Q = "1001") then Cout <= '1' ; Qint <= "0000";
			elsif (ENABLE = '1' and UP = '0' and Q = "0000") then Cout <= '1' ; Qint <= "1001";
			elsif (LOAD = '0' and ENABLE = '1' and UP = '1') then Cout <= '0' ; Qint <= Q + 1;
			elsif (LOAD = '0' and ENABLE = '1' and UP = '0') then Cout <= '0' ; Qint <= Q - 1;
			else Qint <= Q ; Cout <= '0';
		end if;
	end if;
	Q <= Qint;

	end process;
end behav;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_bit.all;

entity digitcounter is 
	port(ENABLE,LOAD,UP,CLR,CLK: in bit;
		D1,D2: IN unsigned(7 downto 4);
		Q1,Q2: inout unsigned(7 downto 4);
		Cout: out bit);
end digitcounter; 

architecture behavior of digitcounter is
component BCDcounter
	port(ENABLE, LOAD, UP, CLR, CLK: IN BIT;
		D: IN unsigned(3 DOWNTO 0);
		Q: INOUT unsigned(3 DOWNTO 0);
		Cout: OUT BIT);
end component;

signal carry1: bit;
begin
	c1: BCDcounter port map(ENABLE,LOAD,UP,CLR,CLK,D1,Q1,carry1);
	c2: BCDcounter port map(carry1,LOAD,UP,CLR,CLK,D2,Q2,Cout);
end behavior;