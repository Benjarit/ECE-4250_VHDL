library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity generate_clock is
	generic(time_period : integer range 1 to 4);
	port(clk : std_logic;
		clk_out : out std_logic);
end generate_clock;

architecture behavior of generate_clock is
signal prescale : unsigned(23 downto 0);
signal clk_out_i : std_logic;
--constant time_period : integer range 1 to 4;

begin
	process(clk)
	begin
		if (clk'event and clk ='1') then
			case time_period is
			when 1 =>
				if prescale = X"BEBC20" then
					prescale <=(others=> '0');
					clk_out_i <= not clk_out_i;
				else
					prescale <= prescale + "1";
				end if;
			when 2 =>
				if prescale = X"17D7840" then
					prescale <=(others=> '0');
					clk_out_i <= not clk_out_i;
				else
					prescale <= prescale + "1";
				end if;
			when 3 =>
				if prescale = X"2FAF080" then
					prescale <=(others=> '0');
					clk_out_i <= not clk_out_i;
				else
					prescale <= prescale + "1";
				end if;
			when 4 =>
				if prescale = X"5F5E100" then
					prescale <=(others=> '0');
					clk_out_i <= not clk_out_i;
				else
					prescale <= prescale + "1";
				end if;
			when others =>
				null;
			end case;
		end if;
	end process;
	clk_out <= clk_out_i;
end behavior;