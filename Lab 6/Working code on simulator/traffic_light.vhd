
library ieee;
use ieee.std_logic_1164.all;
ENTITY traffic_light3 is
  PORT (clk,PB: in std_logic;   
	Ga, Ya, Ra, WALK, NOWALK: out std_logic); 
END traffic_light3; 

architecture behave of traffic_light3 is
signal state,nextstate: integer range 0 to 13:=0;
--signal sFW: std_logic;
signal clock1, clock2: std_logic := '1' ;
begin

	process(state,PB,clock2)
	begin
		Ga <= '0'; Ya <= '0'; Ra <= '0'; WALK <= '0'; NOWALK <= '0'; --sFW <= '0';
	case state is
	when 0 to 6 =>
		nextstate <= state + 1; Ga <= '1'; NOWALK <= '1';
	when 7 => 
		if PB = '1' then nextstate <= 8; NOWALK <= '1'; Ga <= '1';
		else nextstate <= 7; Ga <= '1';
		end if;
	when 8 =>
		nextstate <= state + 1; Ya <= '1'; NOWALK <= '1';
	when 9 to 11 =>
		nextstate <= state + 1; Ra <= '1'; WALK <= '1';
	when 12 =>
		nextstate <= state + 1; Ra <= '1'; WALK <= '1';
	when 13 =>
		nextstate <= 0; Ra <= '1'; WALK <= clock2;
	end case;
	end process;

	process(clock1)
	begin
		if clock1'event and clock1 = '1' then
			state <= nextstate;
		end if;
	end process;
	clock1 <= not clock1 after 4000 ms;
	clock2 <= not clock2 after 1000 ms;
	--WALK <= clock2 when sFW='1' else '1' when ;
	
	--c1: GenClock generic map(1) port map(clk, clock1);
	--c2: GenClock generic map(2) port map(clk, clock2);
end behave;