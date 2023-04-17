----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2023 19:00:49
-- Design Name: 
-- Module Name: MUX - Behavioral
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

entity MUX is
    Port ( cero : in STD_LOGIC_VECTOR (15 downto 0);
           uno : in STD_LOGIC_VECTOR (15 downto 0);
           reg_dataout : in STD_LOGIC_VECTOR (15 downto 0);
           lit : in STD_LOGIC_VECTOR (15 downto 0);
           sel_mux : in STD_LOGIC_VECTOR (1 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0));
end MUX;

architecture synth of MUX is

begin

process (sel_mux, cero, uno, reg_dataout, lit) is
 begin
 
    case sel_mux is
        when "00" => output <= cero;      --0
        when "01" => output <= uno;   --B
        when "10" => output <= reg_dataout;       --Mem[Dir]
        when "11" => output <= lit;      --literal
        when others => output <= cero;
    end case;
end process;

end synth;
