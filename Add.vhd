library ieee;
use ieee.std_logic_1164.all;

entity Add is
port (
InputAddress: in std_logic_vector(31 downto 0);
Addout: out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behavioral of Add is
	signal
		begin
        Addout <= InputAddress + 4;
        
end architecture; --behavioral