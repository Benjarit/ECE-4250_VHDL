library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity test_clock is
	port(clk : in std_logic;
		led1,led2,led3,led4 : out std_logic);
end test_clock;
architecture behavior of test_clock is
component generate_clock is
	generic(time_period : integer range 1 to 4);
	port(clk : std_logic;
		clk_out : out std_logic);
end component;
begin
	clk1 : generate_clock generic map(1) port map(clk,led1);
	clk2 : generate_clock generic map(2) port map(clk,led2);	
	clk3 : generate_clock generic map(3) port map(clk,led3);
	clk4 : generate_clock generic map(4) port map(clk,led4);
end behavior;