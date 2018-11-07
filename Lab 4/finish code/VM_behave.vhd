library IEEE;
use IEEE.numeric_bit.all;

entity vending is--entity declaration
	port(N,D, CLK : in bit;
	     disp_drink,ret_nickel : out bit);
end vending;

architecture Table of vending is

signal result : bit_vector(0 to 3);--result should match the rom table
signal next_state : bit_vector(0 to 1);
signal state : bit_vector(0 to 1);
begin
	process(state,N,D)
	begin
		disp_drink<='0'; ret_nickel <='0;
		case state is--checks the current state and assigns the value of the next state, accordingly 
			when "00" =>
				if(N = '1' and D = '0') then
					next_state <= "01";
				elsif(N = '0' and D = '1') then
					next_state <= "10";
				end if;
			when "01" =>
				if(N = '1' and D = '0') then 
					next_state <= "10";
				elsif(N = '0' and D = '1') then 
					next_state <= "11";
				end if;
			when "10" =>
				if(N = '1' and D = '0') then
					next_state <= "11";
				elsif(N = '0' and D = '1') then 
					next_state <= "00";disp_drink<='1';
				end if;
			when "11" =>
				if(N = '1' and D = '0') then
					next_state <= "00";disp_drink<='1';
				elsif(N = '0' and D = '1') then 
					next_state <= "00";disp_drink<='1';ret_nickel<='1';
				end if;
		end case;
	end process;
	process (CLK)
	begin
			if(CLK'event and CLk = '1') then
			state <= next_state;
			end if;
	end process;
	
	--state <= next_state; --assigns the current state to the next state
	--disp_drink <= '1' when ((state = "10" and D = '1') or (state = "11" and D = '1') or (state = "11" and N = '1'))--assigns the value of disp_drink and ret_nickel, depending on the current state and the coin entered
		--else '0';
	--ret_nickel <= '1' when (state = "11" and D = '1')
		--else '0';
end Table;