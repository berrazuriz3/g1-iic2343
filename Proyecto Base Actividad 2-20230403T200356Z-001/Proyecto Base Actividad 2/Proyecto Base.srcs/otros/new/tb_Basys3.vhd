library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_Basys3 is
--  Port ( );
end tb_Basys3;

architecture Behavioral of tb_Basys3 is

component Basys3
    Port (
        sw          : in   std_logic_vector (15 downto 0); -- No Tocar - Se?ales de entrada de los interruptores -- Arriba   = '1'   -- Los 16 swiches.
        btn         : in   std_logic_vector (4 downto 0);  -- No Tocar - Se?ales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (15 downto 0); -- No Tocar - Se?ales de salida  a  los leds          -- Prendido = '1'   -- Los 16 leds.
        clk         : in   std_logic;                      -- No Tocar - Se?al de entrada del clock              -- Frecuencia = 100Mhz.
        seg         : out  std_logic_vector (7 downto 0);  -- No Tocar - Salida de las se?ales de segmentos.
        an          : out  std_logic_vector (3 downto 0)   -- No Tocar - Salida del selector de diplay.
          );
end component Basys3;

component ControlUnit is -- No Tocar
    Port (ROM_dataout : in std_logic_vector (19 downto 0);
           CZN : in std_logic_vector (2 downto 0);
           enableA : out std_logic;
           enableB : out std_logic;
           selA : out std_logic_vector (1 downto 0);
           selB : out std_logic_vector (1 downto 0);
           loadPC : out std_logic;
           selALU : out std_logic_vector (2 downto 0);
           w : out std_logic);
end component ControlUnit;

component ROM is
    Port ( DataIn : in STD_LOGIC_VECTOR (35 downto 0);
           address : in STD_LOGIC_VECTOR (11 downto 0);
           write : in STD_LOGIC;
           disable : in STD_LOGIC;
           clock : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (35 downto 0));
end component ROM;

-- Inicio de la declaraci?n de se?ales.

signal d_btn            : std_logic_vector(4 downto 0);  -- Se?ales de botones con anti-rebote.
  
signal clock            :std_logic;
            
signal dis_a            : std_logic_vector(3 downto 0);  -- Se?ales de salida al display A.    
signal dis_b            : std_logic_vector(3 downto 0);  -- Se?ales de salida al display B.     
signal dis_c            : std_logic_vector(3 downto 0);  -- Se?ales de salida al display C.    
signal dis_d            : std_logic_vector(3 downto 0);  -- Se?ales de salida al display D.

signal c : std_logic;
signal z : std_logic;
signal n : std_logic;
signal count_in :std_logic_vector (11 downto 0);
signal clear    : std_logic;
     
signal RAM_out        : std_logic_vector(15 downto 0); 
signal RAM_datain     : std_logic_vector(15 downto 0);
signal ROM_out        : std_logic_vector(35 downto 0);
signal ROM_address     : std_logic_vector(11 downto 0);
signal ROM_datain     : std_logic_vector(35 downto 0);
signal write_ROM      : std_logic; 
signal s_status_out        : std_logic_vector(2 downto 0);
signal a                : std_logic_vector(15 downto 0);  -- Se?ales del primer operador.    
signal b                : std_logic_vector(15 downto 0);  -- Se?ales del segundo operador.
signal lit            : std_logic_vector(15 downto 0); 
signal outmux_a               : std_logic_vector(15 downto 0); 
signal outmux_b              : std_logic_vector(15 downto 0);  

signal sel_A            : std_logic_vector(1 downto 0);
signal sel_B            : std_logic_vector(1 downto 0);
signal loadPC           : std_logic;
signal enable_A         : std_logic;
signal enable_B         : std_logic;
signal sel_ALU          : std_logic_vector(2 downto 0);
signal result           : std_logic_vector(15 downto 0);  -- Se?ales del resultado.
signal dataout_reg_a    : std_logic_vector(15 downto 0);  -- Se?ales del primer operador.    
signal dataout_reg_b    : std_logic_vector(15 downto 0);  -- Se?ales del segundo operador.
signal dis              : std_logic_vector(15 downto 0);

signal datain           : std_logic_vector(15 downto 0);  -- Se?ales de datos de entrada a los registros.

signal temp_rom              : std_logic_vector(35 downto 0);

begin

inst_ControlUnit: ControlUnit port map( 
    ROM_dataout  => ROM_out(19 downto 0),
    CZN          => s_status_out,
    enableA      => enable_A,
    enableB      => enable_B,
    selA         => sel_A,
    selB         => sel_B,
    loadPC       => loadPC,
    selALU       => sel_ALU
    );
    
process
begin
temp_rom <= "000000000000010000000000000000000010";
ROM_out <= a(19 downto 0);

wait for 10ns;
temp_rom <= "000000000000000000000000000000000011";
ROM_out <= a(19 downto 0);

wait for 10ns;
temp_rom <= "000000000000000000000000000000000110";
ROM_out <= a(19 downto 0);

wait for 10ns;
temp_rom <= "000000000000000100000000000000000111";
ROM_out <= a(19 downto 0);


end process;

end Behavioral;
