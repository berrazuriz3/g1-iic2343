library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (15 downto 0); -- No Tocar - Señales de entrada de los interruptores -- Arriba   = '1'   -- Los 16 swiches.
        btn         : in   std_logic_vector (4 downto 0);  -- No Tocar - Señales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (15 downto 0); -- No Tocar - Señales de salida  a  los leds          -- Prendido = '1'   -- Los 16 leds.
        clk         : in   std_logic;                      -- No Tocar - Señal de entrada del clock              -- Frecuencia = 100Mhz.
        seg         : out  std_logic_vector (7 downto 0);  -- No Tocar - Salida de las señales de segmentos.
        an          : out  std_logic_vector (3 downto 0)   -- No Tocar - Salida del selector de diplay.
          );
end Basys3;

architecture Behavioral of Basys3 is

-- Inicio de la declaración de los componentes.
    
component Debouncer -- No Tocar
    Port (
        clk         : in    std_logic;
        signal_in   : in    std_logic;
        signal_out  : out   std_logic
          );
    end component;
    
component Display_Controller -- No Tocar
    Port (  
        dis_a       : in    std_logic_vector (3 downto 0);
        dis_b       : in    std_logic_vector (3 downto 0);
        dis_c       : in    std_logic_vector (3 downto 0);
        dis_d       : in    std_logic_vector (3 downto 0);
        clk         : in    std_logic;
        seg         : out   std_logic_vector (7 downto 0);
        an          : out   std_logic_vector (3 downto 0)
          );
    end component;
    
component Reg -- No Tocar
    Port (
        clock       : in    std_logic;
        clear       : in    std_logic;
        load        : in    std_logic;
        up          : in    std_logic;
        down        : in    std_logic;
        datain      : in    std_logic_vector (15 downto 0);
        dataout     : out   std_logic_vector (15 downto 0)
          );
    end component;

component ALU -- No Tocar
    Port ( 
        a           : in    std_logic_vector (15 downto 0);
        b           : in    std_logic_vector (15 downto 0);
        sop         : in    std_logic_vector (2 downto 0);
        c           : out   std_logic;
        z           : out   std_logic;
        n           : out   std_logic;
        result      : out   std_logic_vector (15 downto 0)
          );
    end component;
    
component MUX is
    Port ( cero : in STD_LOGIC_VECTOR (15 downto 0);
           uno : in STD_LOGIC_VECTOR (15 downto 0);
           reg_dataout : in STD_LOGIC_VECTOR (15 downto 0);
           lit : in STD_LOGIC_VECTOR (15 downto 0);
           sel_mux : in STD_LOGIC_VECTOR (1 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end component MUX;

component Status is
    Port ( C : in STD_LOGIC;
           Z : in STD_LOGIC;
           N : in STD_LOGIC;
           clear : in STD_LOGIC;
           clock : in STD_LOGIC;
           status_out : out STD_LOGIC_VECTOR (2 downto 0));
end component Status;

component PC is
    Port ( clock    : in STD_LOGIC;
           count_in : in STD_LOGIC_VECTOR (11 downto 0);
           load_pc : in STD_LOGIC;
           clear : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (11 downto 0));
end component PC;

-- Fin de la declaración de los componentes.

-- Inicio de la declaración de señales.

signal d_btn            : std_logic_vector(4 downto 0);  -- Señales de botones con anti-rebote.
            
signal dis_a            : std_logic_vector(3 downto 0);  -- Señales de salida al display A.    
signal dis_b            : std_logic_vector(3 downto 0);  -- Señales de salida al display B.     
signal dis_c            : std_logic_vector(3 downto 0);  -- Señales de salida al display C.    
signal dis_d            : std_logic_vector(3 downto 0);  -- Señales de salida al display D.

signal c : std_logic;
signal z : std_logic;
signal n : std_logic;
     
signal RAM_out        : std_logic_vector(15 downto 0); 
signal ROM_out        : std_logic_vector(15 downto 0); 
signal s_status_out        : std_logic_vector(2 downto 0);
signal a                : std_logic_vector(15 downto 0);  -- Señales del primer operador.    
signal b                : std_logic_vector(15 downto 0);  -- Señales del segundo operador.
signal lit            : std_logic_vector(15 downto 0); 
signal outmux_a               : std_logic_vector(15 downto 0); 
signal outmux_b              : std_logic_vector(15 downto 0);  

signal sel_A            : std_logic_vector(1 downto 0);
signal sel_B            : std_logic_vector(1 downto 0);
signal enable_A         : std_logic;
signal enable_B         : std_logic;
signal sel_ALU          : std_logic_vector(2 downto 0);
signal result           : std_logic_vector(15 downto 0);  -- Señales del resultado.

signal datain           : std_logic_vector(15 downto 0);  -- Señales de datos de entrada a los registros.


-- Fin de la declaración de señales.

begin

-- Inicio de declaración de comportamientos.

-- Muxer Regs
with sw(12) select
    datain <= result            when '0',
              sw(15 downto 0)    when others;

-- Muxers del Display
with btn(0) select
    dis_a <= a(7 downto 4)      when '0',
             "0000"             when others;
                     
with btn(0) select
    dis_b <= a(3 downto 0)      when '0',
             "0000"             when others;

with btn(0) select
    dis_c <= b(7 downto 4)      when '0',
             result(7 downto 4) when others;
                
with btn(0) select
    dis_d <= b(3 downto 0)      when '0',
             result(3 downto 0) when others;


-- Inicio de declaración de instancias.

inst_REG_A: Reg port map( -- Repárame!
    clock       => d_btn(2),
    clear       => '0',
    load        => '1',
    up          => '0',
    down        => '0',
    datain      => datain,
    dataout     => a
    );
    
inst_REG_B: Reg port map( -- Repárame!
    clock       => d_btn(3),
    clear       => '0',
    load        => '1',
    up          => '0',
    down        => '0',
    datain      => datain,
    dataout     => b
    );
 
 inst_ALU: ALU port map(
    a           => a,
    b           => b,
    sop         => sw(15 downto 13),
    c           => c,
    z           => z,
    n           => n,
    result      => result
    );

-- Intancia de Display_Controller.        
inst_Display_Controller: Display_Controller port map(
    dis_a => dis_a, 
    dis_b => dis_b, 
    dis_c => dis_c, 
    dis_d => dis_d,     
    clk => clk ,        -- No Tocar - Entrada del clock completo (100Mhz).
    seg => seg,         -- No Tocar - Salida de las señales de segmentos. 
    an => an            -- No Tocar - Salida del selector de diplay.
    );
    
inst_MUX_A: MUX port map(
    cero => "0000000000000000",
    uno => "0000000000000001",
    reg_dataout => a,
    lit => lit,
    sel_mux => sel_A,
    output => outmux_a
    );
    
inst_MUX_B: MUX port map(
    cero => "0000000000000000",
    uno => "0000000000000001",
    reg_dataout => b,
    lit => ROM_out,
    sel_mux => sel_A,
    output => outmux_a
    );
    
inst_Status: Status port map(
    C => c,
    Z => z,
    N => n,
    clear => '0',
    clock => d_btn(3),
    status_out => s_status_out
    );
    
inst_PC: PC port map(
    clock       => d_btn(3),
    count_in    => muxer_pc,
    loadPC      => load_PC,
    up          => '1',
    down        => '0',
    clear       => clear,
    output      => outPC
    );

-- No Tocar - Intancias de Debouncers.    
inst_Debouncer0: Debouncer port map( clk => clk, signal_in => btn(0), signal_out => d_btn(0) );
inst_Debouncer1: Debouncer port map( clk => clk, signal_in => btn(1), signal_out => d_btn(1) );
inst_Debouncer2: Debouncer port map( clk => clk, signal_in => btn(2), signal_out => d_btn(2) );
inst_Debouncer3: Debouncer port map( clk => clk, signal_in => btn(3), signal_out => d_btn(3) );
inst_Debouncer4: Debouncer port map( clk => clk, signal_in => btn(4), signal_out => d_btn(4) );
    
-- Fin de declaración de instancias.

-- Fin de declaración de comportamientos.
  
end Behavioral;