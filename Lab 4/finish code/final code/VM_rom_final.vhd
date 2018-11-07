library IEEE;
use IEEE.numeric_bit.all;

entity vending_rom is--entity declaration
	port(N,D, CLK : in bit;
	     disp_drink,ret_nickel : out bit);
end vending_rom;

architecture Table of vending_rom is

type rom_inputTable is array (0 to 15) of bit_vector(0 to 3);--input table and an output table, could use the same type if we wished
type rom_outputTable is array (0 to 15) of bit_vector(0 to 3);

constant rom_IT : rom_inputTable := ("0000","0001","0010","0011","0100","0101","0110","0111","1000","1001","1010","1011","1100","1101","1110","1111");--these values come from the state transition diagram
constant rom_OT : rom_outputTable := ("0000","0100","1000","0000","0100","1000","1100","0000","1000","1100","0001","0000","1100","0001","0011","0000");

signal NS : bit_vector(0 to 1);--signal to hold the next state
signal input_vector : bit_vector(0 to 3);
signal output_vector : bit_vector(0 to 3);
signal PS : bit_vector(0 to 1); 
begin 
	process(CLK)
	begin 
		if(CLK'event and CLK = '1') then
			PS <= NS;
		end if;
	end process;
	input_vector <= PS & D & N;--concatenate the inputs together to get the rom index
--cast unsigned and use to_integer to convert from std_locgic_vector to integer
			output_vector <= rom_OT(to_integer(unsigned(input_vector)));--assigns the output vector
	NS <= output_vector(0 to 1);--assigns the current state to the next state from the process
	ret_nickel <= output_vector(2);--sets to the third element of the output vector
	disp_drink <= output_vector(3);	--sets to the last element
end Table;