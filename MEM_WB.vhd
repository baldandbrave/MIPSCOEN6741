-- falling_edge(Clock) for write and read Register at the same time, need validation
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity MEM_WB is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;

    ReadDataIn      : in std_logic_vector(31 downto 0) ;
    ALUResultIn     : in std_logic_vector(31 downto 0) ;

    ReadDataOut     : out std_logic_vector(31 downto 0) ;
    ALUResultOut    : out std_logic_vector(31 downto 0) ;
  ) ;
end MEM_WB ; 

architecture Behavior of MEM_WB is

begin
  MEM_WB : process( Clock, Reset )
  begin
    if Reset = '1' then
      null;
    elsif falling_edge(Clock) then
      ReadDataOut <= ReadDataIn;
      ALUResultOut <= ALUResultIn;
    end if ;
  end process ; -- MEM_WB
end architecture ;