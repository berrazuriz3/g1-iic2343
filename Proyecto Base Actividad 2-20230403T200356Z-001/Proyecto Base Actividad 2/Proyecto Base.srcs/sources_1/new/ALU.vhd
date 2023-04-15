library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( a        : in  std_logic_vector (15 downto 0);   -- Primer operando.
           b        : in  std_logic_vector (15 downto 0);   -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);   -- Selector de la operación.
           c        : out std_logic;                       -- Señal de 'carry'.
           z        : out std_logic;                       -- Señal de 'zero'.
           n        : out std_logic;                       -- Señal de 'nagative'.
           result   : out std_logic_vector (15 downto 0));  -- Resultado de la operación.
end ALU;

architecture Behavioral of ALU is

signal alu_result   : std_logic_vector(15 downto 0);
signal adder_result   : std_logic_vector(15 downto 0);
signal adder_b   : std_logic_vector(15 downto 0);
signal adder_cout   : std_logic;
signal adder_ci   : std_logic;

component Adder8 is
    Port ( a  : in  std_logic_vector (15 downto 0);
           b  : in  std_logic_vector (15 downto 0);
           ci : in  std_logic;
           s  : out std_logic_vector (15 downto 0);
           co : out std_logic);
end component Adder8;

begin

with sop select
 adder_b <= not b when "001",
            b when others;
            
with sop select
 adder_ci <= '1' when "001",
             '0' when others;

-- Sumador/Restaror

Adder : Adder8 Port map(
  a => a,
  b => adder_b,
  ci => adder_ci,
  s => adder_result, 
  co => adder_cout
  );
                
-- Resultado de la Operación
               
with sop select
    alu_result <= adder_result     when "000", --suma
                  adder_result     when "001", --resta
                  a and b          when "010", --and
                  a or b           when "011", --or
                  a xor b          when "100", --xor
                  not a            when "101", --not
                  '0' & a(15 downto 1) when "110", --shr
                  a(14 downto 0) & '0' when "111"; --shl
                  
result  <= alu_result;

-- Flags c z n

with sop select
 c <= adder_cout when "000",
      adder_cout when "001",
      a(0) when "011",
      a(15) when "111",
      '0' when others;
      
with sop select
 n <=  not adder_cout when "001",
      '0' when others;

with alu_result select
 z <= '1' when "00000000",
      '0' when others;
             
               
    
end Behavioral;

