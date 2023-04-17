
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder8 is
    Port ( a  : in  std_logic_vector (15 downto 0);
           b  : in  std_logic_vector (15 downto 0);
           ci : in  std_logic;
           s  : out std_logic_vector (15 downto 0);
           co : out std_logic);
end Adder8;

architecture Behavioral of Adder8 is

component FA
    Port ( a  : in  std_logic;
           b  : in  std_logic;
           ci : in  std_logic;
           s  : out std_logic;
           co : out std_logic);
    end component;

signal c : std_logic_vector(14 downto 0);

begin

inst_FA0: FA port map(
        a      =>a(0),
        b      =>b(0),
        ci     =>ci,
        s      =>s(0),
        co     =>c(0)
    );
    
inst_FA1: FA port map(
        a      =>a(1),
        b      =>b(1),
        ci     =>c(0),
        s      =>s(1),
        co     =>c(1)
    );

inst_FA2: FA port map(
        a      =>a(2),
        b      =>b(2),
        ci     =>c(1),
        s      =>s(2),
        co     =>c(2)
    );

inst_FA3: FA port map(
        a      =>a(3),
        b      =>b(3),
        ci     =>c(2),
        s      =>s(3),
        co     =>c(3)
    );

inst_FA4: FA port map(
        a      =>a(4),
        b      =>b(4),
        ci     =>c(3),
        s      =>s(4),
        co     =>c(4)
    );
    
inst_FA5: FA port map(
        a      =>a(5),
        b      =>b(5),
        ci     =>c(4),
        s      =>s(5),
        co     =>c(5)
    );

inst_FA6: FA port map(
        a      =>a(6),
        b      =>b(6),
        ci     =>c(5),
        s      =>s(6),
        co     =>c(6)
    );

inst_FA7: FA port map(
        a      =>a(7),
        b      =>b(7),
        ci     =>c(6),
        s      =>s(7),
        co     =>c(7)
    );
    
inst_FA8: FA port map(
        a      =>a(8),
        b      =>b(8),
        ci     =>c(7),
        s      =>s(8),
        co     =>c(8)
    );

inst_FA9: FA port map(
        a      =>a(9),
        b      =>b(9),
        ci     =>c(8),
        s      =>s(9),
        co     =>c(9)
    );

inst_FA10: FA port map(
        a      =>a(10),
        b      =>b(10),
        ci     =>c(9),
        s      =>s(10),
        co     =>c(10)
    );

inst_FA11: FA port map(
        a      =>a(11),
        b      =>b(11),
        ci     =>c(10),
        s      =>s(11),
        co     =>c(11)
    );

inst_FA12: FA port map(
        a      =>a(12),
        b      =>b(12),
        ci     =>c(11),
        s      =>s(12),
        co     =>c(12)
    );

inst_FA13: FA port map(
        a      =>a(13),
        b      =>b(13),
        ci     =>c(12),
        s      =>s(13),
        co     =>c(13)
    );

inst_FA14: FA port map(
        a      =>a(14),
        b      =>b(14),
        ci     =>c(13),
        s      =>s(14),
        co     =>c(14)
    );

inst_FA15: FA port map(
        a      =>a(15),
        b      =>b(15),
        ci     =>c(14),
        s      =>s(15),
        co     =>co
    );

end Behavioral;
