library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity PC is
    Port ( clock    : in STD_LOGIC;
           count_in : in STD_LOGIC_VECTOR (11 downto 0);
           load_pc : in STD_LOGIC;
           clear : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (11 downto 0));
end PC;

architecture Behavioral of PC is

signal pc : std_logic_vector(11 downto 0) := (others => '0'); -- Señales del registro parten en 0.

begin

pc_prosses : process (clock, load_pc, clear)        -- Proceso sensible a clock, loadPc y clear.
        begin
          if (clear = '1') then             -- Si clear = 1
            pc <= (others => '0');         -- Carga 0 en el registro.
          elsif (rising_edge(clock)) then   -- Si flanco de subida de clock.
            if (load_pc = '1') then            -- Si clear = 0, load = 1.
                pc <= count_in;              -- Carga la entrada de datos en el registro.
            elsif (up = '1') then           -- Si clear = 0,load = 0 y up = 1.
                pc <= pc + 1;             -- Incrementa el registro en 1.
            elsif (down = '1') then         -- Si clear = 0,load = 0, up = 0 y down = 1. 
                pc <= pc - 1;             -- Decrementa el registro en 1.          
            end if;
          end if;
        end process;
        
output <= pc;                             -- Los datos del registro salen sin importar el estado de clock.


end Behavioral;
