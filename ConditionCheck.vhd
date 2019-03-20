library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity ConditionCheck is
  port (
    ReadData1 : in std_logic_vector(31 downto 0) ;
    ReadData2 : in std_logic_vector(31 downto 0) ;
    Equal     : out std_logic
  ) ;
end ConditionCheck ; 

architecture Behavior of ConditionCheck is

begin
    Equal <= '0' when (ReadData1 xor ReadData2 = x"00000000")
                 else
                    '1';
end architecture ;