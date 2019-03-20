library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity EX_MEM is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;

    ALUResultIn     : in std_logic_vector(31 downto 0) ;
    MemWriteIn      : in std_logic;
    
    ALUResultOut    : out std_logic_vector(31 downto 0) ;
    MemWriteOut     : out std_logic;
  ) ;
end EX_MEM ; 

architecture Behavior of EX_MEM is

begin
  EX_MEM : process( Clock, Reset )
  begin
    if Reset = '1' then
      ALUResultOut <= (others => 0);
      MemWriteOut <= '0';
    elsif falling_edge(Clock) then
      ALUResultOut <= ALUResultIn;
      MemWriteOut <= MemWriteIn;
    end if ;
  end process ; -- EX_MEM
end architecture ;