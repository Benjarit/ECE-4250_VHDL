library IEEE;
use IEEE.std_logic_1164.all;

entity TestClock is
	Port(clk: in std_logic; led1,led2,led3,led4: out std_logic);
end TestClock;

architecture Execute of TestClock is
	component GenClock is
		Generic (time_period : integer range 1 to 4);
		Port(clk: in std_logic; Clock: out std_logic);
	end component;

	begin
	time1:GenClock generic map(1) port map(clk,led1);      ---0.5 second
	time2:GenClock generic map(2) port map(clk,led2);       ---1 second
	time3:GenClock generic map(3) port map(clk,led3);     ---2 second
	time4:GenClock generic map(4) port map(clk,led4);     ---4 second
end Execute;
