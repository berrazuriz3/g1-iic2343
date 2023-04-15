----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2023 18:14:12
-- Design Name: 
-- Module Name: CPU - Behavioral
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

entity CPU is
    Port ( RAM_datain : out STD_LOGIC_VECTOR (15 downto 0);
           RAM_adress : out STD_LOGIC_VECTOR (11 downto 0);
           RAM_write : out STD_LOGIC;
           RAM_dataout : in STD_LOGIC_VECTOR (15 downto 0);
           ROM_adress : out STD_LOGIC_VECTOR (11 downto 0);
           ROM_dataout : in STD_LOGIC_VECTOR (35 downto 0);
           clear : in STD_LOGIC);
end CPU;

architecture Behavioral of CPU is

begin


end Behavioral;
