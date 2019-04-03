-- rising edge write, falling edge read, verified in Registers.
library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity MEM_WB is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;

    ReadDataIn      : in std_logic_vector(31 downto 0) ;
    ALUResultIn     : in std_logic_vector(31 downto 0) ;
    TargetRegIn     : in std_logic_vector(4 downto 0) ;
    -- WB signals
    MemToReg        : in std_logic;
    RegWrite        : in std_logic;

    TargetRegOut    : out std_logic_vector(4 downto 0) ;
    ReadDataOut     : out std_logic_vector(31 downto 0) ;
    ALUResultOut    : out std_logic_vector(31 downto 0) ;
    MemToRegOut     : out std_logic;
    RegWriteOut       : out std_logic
  ) ;
end MEM_WB ; 

architecture Behavior of MEM_WB is

begin
  MEM_WB : process( Clock, Reset )
  begin
    if Reset = '1' then
      null;
    elsif rising_edge(Clock) then
      TargetRegOut <= TargetRegIn;
      ReadDataOut <= ReadDataIn;
      ALUResultOut <= ALUResultIn;
      MemToRegOut <= MemToReg;
      RegWriteOut <= RegWrite;
    end if ;
  end process ; -- MEM_WB
end architecture ;