library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;


entity lab7bench is
 port (   start, pb0, pb1	: 	in std_logic;
        sw7,sw6,sw5,sw4,sw3,sw2,sw1,sw0: in std_logic;-- Inputs
            CLK: in std_logic;
	   AN0, AN1, AN2, AN3	:	out std_logic;
        segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g, segment_dp :	out std_logic);
end lab7bench;

Architecture test1 of lab7bench is

component AnodeControl 
port (CLK	: in std_logic;  
  	   counter_out	:	out std_logic_vector (2 downto 0);
	   Anode	:	out std_logic_vector (3 downto 0));
end component;

component LEDDisplay is
  port (  output1 	: 	in std_logic_vector(15 downto 0);  -- Inputs		
	   counter:	in std_logic_vector(2 downto 0);
        segment_a, segment_b, segment_c, segment_d, segment_e, segment_f, segment_g :	out std_logic);
end component;

component bcd2bin is
	port (CLK, start, pb0_con, pb1_con : in std_logic;  input: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(15 downto 0) );
end component;


signal counter:	std_logic_vector (2 downto 0);
signal Anode:	std_logic_vector (3 downto 0);
signal output2, output3: std_logic_vector (15 downto 0);
signal input: std_logic_vector(7 downto 0);
--signal switch0, switch1, switch2, switch3, switch4, switch5, switch6, switch7: std_logic;

begin

AN0 <= Anode(0);
AN1 <= Anode(1);
AN2 <= Anode(2);
AN3 <= Anode(3);
segment_dp <= '1';
--done<='1';

--switch0<=sw0;
--switch1<=sw1;
--switch2<=sw2;
--switch3<=sw3;
--switch4<=sw4;
--switch5<=sw5;
--switch6<=sw6;
--switch7<=sw7;

--input <= switch7 & switch6 & switch5 & switch4 & switch3 & switch2 & switch1 & switch0;
input <= sw7 & sw6 & sw5 & sw4 & sw3 & sw2 & sw1 & sw0;

bcd2binmap: bcd2bin port map (CLK, start, pb0, pb1, input, output3);
ANDisplay : AnodeControl port map (clk,counter,Anode);
LEDDisplay0 : LEDDisplay  port map (output3,counter,segment_a,segment_b,segment_c,segment_d,segment_e,segment_f,segment_g);

end test1;
