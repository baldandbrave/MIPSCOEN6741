-- Data hazards: RAW
-- Dependency between 1,2 stage: 2cc
-- Dependency between 1,3 stage: 1cc
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity DataHarzardUnit is
  port (
    IFIDInst    : in std_logic_vector(31 downto 0) ;
    IDEXInst    : in std_logic_vector(31 downto 0) ;
    EXMEMInst   : in std_logic_vector(31 downto 0) 
  ) ;
end DataHarzardUnit ; 

architecture Behavior of DataHarzardUnit is

begin
    DataHarzard : process( )
    begin

        
    end process ; -- DataHarzard
end architecture ;