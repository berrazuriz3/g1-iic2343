library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Status is
    Port ( C : in STD_LOGIC;
           Z : in STD_LOGIC;
           N : in STD_LOGIC;
           clear : in STD_LOGIC;
           clock : in STD_LOGIC;
           status_out : out STD_LOGIC_VECTOR (2 downto 0));
end Status;

architecture Behavioral of Status is

signal status : std_logic_vector(2 downto 0) := (others => '0'); -- Señales del registro parten en 0

begin

reg_prosses : process (clock, clear)        -- Proceso sensible a clock y clear.
        begin
          if (clear = '1') then             -- Si clear = 1
            status <= (others => '0');         -- Carga 0 en el registro.
          elsif (rising_edge(clock)) then   -- Si flanco de subida de clock.
            status <= c & z & n;                 
            end if;
        end process;
        
status_out <= status;               
 

end Behavioral;
