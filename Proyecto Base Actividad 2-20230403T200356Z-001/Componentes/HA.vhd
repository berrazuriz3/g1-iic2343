library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity HA is
    Port ( a : in std_logic;
           b : in std_logic;
           s : out std_logic;
           c : out std_logic);
end HA;

architecture Behavioral of HA is

begin

s <= a xor b;
c <= a and b;

end Behavioral;
