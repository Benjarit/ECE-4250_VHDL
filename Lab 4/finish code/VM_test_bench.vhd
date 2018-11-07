library IEEE;
use IEEE.numeric_bit.all;
entity test_bench is --empty entity
end test_bench;
architecture behavior of test_bench is
component vending--adding the behavioral model as a component
	port(N,D, CLK: in bit;
	     disp_drink,ret_nickel: out bit);
end component;
constant num : integer := 7;
type test_array is array(0 to num) of bit;
type test_array1 is array(0 to num) of bit_vector(0 to 1);

constant input_arr : test_array1 := ("01","01","01","01","10","10","00","00");
constant disp_arr : test_array := ('0','0','0','1','0','1','0','0');
constant ret_arr : test_array := ('0','0','0','0','0','0','0','0');

signal Ni : bit;--declaring all of the signals we will be needing since we use an empty entity
signal Da : bit;
signal di: bit;
signal re: bit;
signal CLK : bit := '1';
signal PS : bit_vector(0 to 1);


begin  
	CLK <= not CLK after 100 ns;
	process
	begin
		for i in 0 to num loop--loops through the number of entries in the table
			
			Ni <= input_arr(i)(1);
			Da <= input_arr(i)(0);
			--PS <= state_arr(i);
			wait for 50 ns;
			assert (di = disp_arr(i) and re = ret_arr(i))--assert statement to see if the results match as expected
				report "ERROR"--the message that gets reported
				severity error;--severity level of incorrect assignment
			wait until(CLK = '1' and CLK'EVENT);
		end loop;
		report "Test Finished!";
	end process;
	
	rom1: vending port map(Ni,Da,CLK,di,re);--this is the component getting called with the signals we declare
end behavior;