library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;  

entity Mux32 is
    Generic ( 
	N : integer := 32
	);
    port (
        MuxControlInput : in std_logic;
        MuxInput_1 : in std_logic_vector ( N - 1 downto 0);
        MuxInput_0 : in std_logic_vector ( N - 1 downto 0);
        MuxOutput : out std_logic_vector ( N - 1 downto 0)
    );
end Mux32;

architecture Behavior of Mux32 is
begin
        Mux32 : process( MuxControlInput )
        begin
            case ( MuxControlInput ) is
		when '0' =>
			MuxOutput <= MuxInput_0;
		when '1' =>
			MuxOutput <= MuxInput_1;
                when others  => NULL;
           end case;
        end process ; -- identifier

end architecture ;