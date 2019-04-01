library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 entity Adder is
	port (
		Adder_input: in std_logic_vector(31 downto 0);
		Adder_output: out std_logic_vector(31 downto 0)
	);
end Adder;	

architecture Behavior of Adder is
begin
	Add4 : process(Adder_input)
	begin
		Adder_output <= std_logic_vector(unsigned(Adder_input) + 4);
	end process; -- Add4
end architecture; -- Behavior
