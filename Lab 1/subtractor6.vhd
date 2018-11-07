library IEEE;
use IEEE.std_logic_1164.all;

entity subtractor6 is 
port (A,B: in std_logic_vector(5 downto 0);
      Bi: in std_logic; --Input
      D: out std_logic_vector(5 downto 0);
      Bo: out std_logic); --output
end subtractor6;

Architecture Structure of subtractor6 is 

component FullSubtractor
port (X,Y,Bin: in std_logic; -- Inputs
        Bout, D: out std_logic); --Outputs
end component;

signal Bs: std_logic_vector(5 downto 1);
begin
        FS1: FullSubtractor port map (A(0), B(0), Bi, Bs(1), D(0));
        FS2: FullSubtractor port map (A(1), B(1), Bs(1), Bs(2), D(1));
        FS3: FullSubtractor port map (A(2), B(2), Bs(2), Bs(3), D(2));
        FS4: FullSubtractor port map (A(3), B(3), Bs(3), Bs(4), D(3));
        FS5: FullSubtractor port map (A(4), B(4), Bs(4), Bs(5), D(4));
        FS6: FullSubtractor port map (A(5), B(5), Bs(5), Bo, D(5));
end Structure;

