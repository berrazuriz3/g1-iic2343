library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    Port ( a  : in std_logic;
           b  : in std_logic;
           ci : in std_logic;
           s  : out std_logic;
           co  : out std_logic);
end FA;

architecture Behavioral of FA is

component HA
    Port ( a  : in std_logic;
           b  : in std_logic;
           s  : out std_logic;
           c  : out std_logic);
    end component;
    
signal s1 : std_logic;
signal c1 : std_logic;
signal c2 : std_logic;

begin

co <= c1 or c2;

inst_HA: HA port map(
        a      =>a,
        b      =>b,
        s      =>s1,
        c      =>c1
    );

inst_HA2: HA port map(
        a      =>s1,
        b      =>ci,
        s      =>s,
        c      =>c2
    );

end Behavioral;
