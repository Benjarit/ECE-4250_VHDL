library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;

entity bcd2bin is 
	port(CLK,start,pb0_con,pb1_con : in std_logic;
			input : std_logic_vector(7 downto 0);
			output : out std_logic_vector(15 downto 0));
end bcd2bin;
architecture behave of bcd2bin is
	signal binary_output, binary_output_f,binary_output_flop : std_logic_vector(15 downto 0) := "0000000000000000";
	signal bcd_input : std_logic_vector(15 downto 0) := "0000000000000000";
	signal bcd_input_flop : std_logic_vector(15 downto 0) := "0000000000000000";
	alias block0 is bcd_input(3 downto 0);	
	alias block1 is bcd_input(7 downto 4);
	alias block2 is bcd_input(11 downto 8);
	alias highbit_block0 is bcd_input_flop(3);
	alias highbit_block1 is bcd_input_flop(7);
	alias highbit_block2 is bcd_input_flop(11);
	signal counter : integer range 0 to 16;
	signal state : integer range 0 to 5 := 0;
	signal nextstate : integer range 0 to 5 := 0;
	signal shift : std_logic;
	signal done : std_logic;
	signal sub0_int,sub1_int,sub2_int : std_logic_vector(3 downto 0);
	signal block0_int,block1_int,block2_int : std_logic_vector(3 downto 0);
	--component sub3 is 
	--	port(input : in std_logic_vector(3 downto 0);
	--		output : out std_logic_vector(3 downto 0));
	--end component;
begin
	process(state,Start,PB0_con,PB1_con)
	begin
		bcd_input <= bcd_input_flop;
		binary_output <= binary_output_f;
		nextstate <= state;
		--done <= '0';
		case state is 
			when 0 =>
				if (Start = '1') then nextstate <= 4; binary_output <= "0000000000000000";
				elsif (PB0_con = '1') then nextstate <= 1; bcd_input(7 downto 0) <= input;
				end if; 
			when 1 =>
				if (PB0_con = '1') then nextstate <= 1;
				elsif (PB0_con = '0') then nextstate <= 2;
				end if;
			when 2 =>
				if (PB1_con = '0') then nextstate <= 2; 
				elsif (PB1_con = '1') then nextstate <= 3; bcd_input(15 downto 8) <= input; 
					--done <= '0';
				end if;
			when 3 =>
				if (PB1_con = '1') then nextstate <= 3;
				elsif (PB1_con = '0') then nextstate <= 0;
				end if;
			when 4 =>
				if(done = '1') then nextstate <= 0; end if;
				if(counter = 15) then
					--done <= '1';
					nextstate <= 0;
				end if;
				if(highbit_block0 = '1') then block0 <= bcd_input_flop(3 downto 0) + "1101"; end if;
				if(highbit_block1 = '1') then block1 <= bcd_input_flop(7 downto 4) + "1101"; end if;
				if(highbit_block2 = '1') then block2 <= bcd_input_flop(11 downto 8) + "1101"; end if;
				if(done = '0') then nextstate <= 5; end if; 

			when 5 =>
				binary_output(14 downto 0) <= binary_output_f(15 downto 1);
				binary_output(15) <= bcd_input_flop(0);
				bcd_input <= '0' & bcd_input_flop(15 downto 1);
				nextstate <= 4; 
				--if(done = '1') then nextstate <= 0; 
				--end if;
		end case;
	end process;
	process(CLK)
	begin 
		if(CLK'event AND CLK = '1') then 
			state <= nextstate;
			if(state = 1) then done <= '0'; end if;
			bcd_input_flop <= bcd_input;
			binary_output_f <= binary_output;
			if(state = 5) then counter <= counter + 1; elsif (counter = 16 and state = 4) then done <= '1'; output <= binary_output; end if; 
			if(state = 3) then counter <= 0; end if;
		end if;
	end process;
	--block0_int <= block0;
	--block1_int <= block1;
	--block2_int <= block2;
	--subtract0 : sub3 port map(bcd_input_flop(3 downto 0),sub0_int);
	---subtract1 : sub3 port map(bcd_input_flop(7 downto 4),sub1_int);
	--subtract2 : sub3 port map(bcd_input_flop(11 downto 8),sub2_int);
	
	--output <= binary_output;
end behave;