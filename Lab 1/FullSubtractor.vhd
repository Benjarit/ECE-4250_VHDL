library IEEE;
use IEEE.std_logic_1164.all;

entity FullSubtractor is
port (X,Y,Bin: in std_logic; -- Inputs
    Bout, D: out std_logic); --Outputs
end FullSubtractor;

Architecture Structure1 of FullSubtractor is 
begin
	D <=( X xor Y xor Bin) after 15 ns;
        Bout <= (((not X) and Y) or ((not X) and Bin) or (Y and Bin)) after 15 ns;
end Structure1;
