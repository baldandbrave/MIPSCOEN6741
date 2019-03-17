library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SignExtend is
  port (
    SignExtend_in: in std_logic_vector(18 downto 0);
    SignExtend_out: out std_logic_vector(31 downto 0)
  ) ;
end SignExtend ;

architecture Behavior of SignExtend is

begin
    SignExtend_Process : process(SignExtend_in)
    begin
        SignExtend_out <= std_logic_vector(resize(signed(SignExtend_in), SignExtend_out'length));
    end process;
    
end architecture ; -- Behavior