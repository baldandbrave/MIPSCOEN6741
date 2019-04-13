library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
 entity Adder is
	port (
		Adder_input: in std_logic_vector(31 downto 0);
		Adder_output: out std_logic_vector(31 downto 0)
	);
end Adder;	

architecture Behavior of Adder is
begin
		-- Adder_output <= std_logic_vector(unsigned(Adder_input) + 4);
	Adder_output <= Adder_input + x"00000004";
end architecture; -- Behavior
