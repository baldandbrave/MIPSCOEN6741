library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftLeft is
  --generic (n1:natural:=32; n2:natural:=32; k:natural:=2);  
  port (
    ShiftLeftin: in std_logic_vector(31 downto 0);
    ShiftLeftout: out std_logic_vector(31 downto 0)
  ) ;
end ShiftLeft ;

architecture Behavior of ShiftLeft is
begin
    ShiftLeft_Process : process(ShiftLeftin)
    begin
        ShiftLeftout <= std_logic_vector(shiftleft(ShiftLeftin, 2));
    end process;


end architecture ; -- Behavior