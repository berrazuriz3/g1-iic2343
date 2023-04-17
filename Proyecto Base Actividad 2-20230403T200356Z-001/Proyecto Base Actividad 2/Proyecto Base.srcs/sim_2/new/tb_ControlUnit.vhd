----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2023 10:24:59 AM
-- Design Name: 
-- Module Name: tb_ControlUnit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_ControlUnit is
--  Port ( );
end tb_ControlUnit;

architecture Behavioral of tb_ControlUnit is

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


component ROM is
    Port ( DataIn : in STD_LOGIC_VECTOR (35 downto 0);
           address : in STD_LOGIC_VECTOR (11 downto 0);
           write : in STD_LOGIC;
           disable : in STD_LOGIC;
           clock : in STD_LOGIC;
           DataOut : out STD_LOGIC_VECTOR (35 downto 0));
end component ROM;

--Inputs
signal a                : std_logic_vector(15 downto 0);  -- Se?ales del primer operador.    
signal b                : std_logic_vector(15 downto 0);  -- Se?ales del segundo operador.
signal result           : std_logic_vector(15 downto 0);  -- Se?ales del resultado.
signal c : std_logic;
signal z : std_logic;
signal n : std_logic;
signal outmux_a               : std_logic_vector(15 downto 0); 
signal outmux_b              : std_logic_vector(15 downto 0);  

signal ROM_out        : std_logic_vector(35 downto 0);
signal ROM_address     : std_logic_vector(11 downto 0);

signal s_status_out        : std_logic_vector(2 downto 0);

signal sel_A            : std_logic_vector(1 downto 0);
signal sel_B            : std_logic_vector(1 downto 0);
signal loadPC           : std_logic;
signal enable_A         : std_logic;
signal enable_B         : std_logic;
signal sel_ALU          : std_logic_vector(2 downto 0);

signal clock    : std_logic;
signal clear    : std_logic;

signal RAM_out        : std_logic_vector(15 downto 0); 
signal RAM_datain     : std_logic_vector(15 downto 0);
signal ROM_datain     : std_logic_vector(35 downto 0);
signal write_ROM      : std_logic; 

begin

clear<='0';
RAM_out <="0000000000000000";

inst_REG_A: Reg port map(
    clock       => clock,
    clear       => clear,
    load        => enable_A,
    up          => '0',
    down        => '0',
    datain      => result,
    dataout     => a
    );
    
inst_REG_B: Reg port map(
    clock       => clock,
    clear       => clear,
    load        => enable_B,
    up          => '0',
    down        => '0',
    datain      => result,
    dataout     => b
    );
 
 inst_ALU: ALU port map(
    a           => outmux_a,
    b           => outmux_b,
    sop         => sel_ALU,
    c           => c,
    z           => z,
    n           => n,
    result      => result
    );

    
inst_MUX_A: MUX port map(
    cero => "0000000000000000",
    uno => "0000000000000001",
    reg_dataout => a,
    lit => "0000000000000000",
    sel_mux => sel_A,
    output => outmux_a
    );
    
inst_MUX_B: MUX port map(
    cero => "0000000000000000",
    uno => b,
    reg_dataout => RAM_out,
    lit => ROM_out(35 downto 20),
    sel_mux => sel_B,
    output => outmux_b
    );
    
inst_Status: Status port map(
    C => c,
    Z => z,
    N => n,
    clear => clear,
    clock => clock,
    status_out => s_status_out
    );
inst_PC: PC port map(
    clock       => clock,
    count_in    => ROM_out(31 downto 20),
    load_pc      => loadPC,
    up          => '1',
    down        => '0',
    clear       => clear,
    output      => ROM_address
    );

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
    
inst_ROM: ROM port map(
    clock         => clock,
    disable     => clear,
    write       => '1',
    address     => ROM_address,
    dataout     => ROM_out,
    DataIn      => ROM_datain
    );
    


    
process
    begin
        wait for 10ns;
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        wait for 10ns;
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        wait for 10ns;
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        wait for 10ns;
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        wait for 10ns;
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        wait for 10ns;
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        wait for 10ns;
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        wait for 10ns;
        clock <= '0';
        wait for 10ns;
        clock <= '1';
        wait for 10ns;
     end process;

end Behavioral;
