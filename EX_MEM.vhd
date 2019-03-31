library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity EX_MEM is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;

    ALUResultIn     : in std_logic_vector(31 downto 0) ;
    ReadData2In     : in std_logic_vector(31 downto 0) ;
    TargetRegIn        : in std_logic_vector(4 downto 0) ; -- from mux of rt&rd

    -- MEM signals
    MemRead         : in std_logic;
    MemWrite        : in std_logic;
    -- WB signals
    MemToReg        : in std_logic;
    RegWrite          : in std_logic;

    ALUResultOut    : out std_logic_vector(31 downto 0) ;
    ReadData2Out    : out std_logic_vector(31 downto 0) ; -- to DM WriteData
    TargetRegOut       : out std_logic_vector(4 downto 0) ; -- to Reg
    MemReadOut      : out std_logic;
    MemWriteOut     : out std_logic;
    MemToRegOut     : out std_logic;
    RegWriteOut       : out std_logic
  ) ;
end EX_MEM ; 

architecture Behavior of EX_MEM is

begin
  EX_MEM : process( Clock, Reset )
  begin
    if Reset = '1' then
      ALUResultOut <= (others => '0');
      MemReadOut <= '0';
      MemWriteOut <= '0';
      MemToRegOut <= '0';
      RegWriteOut <= '0';
      TargetRegOut <= (others => '0');
      ReadData2Out <= (others => '0');
    elsif falling_edge(Clock) then
      ALUResultOut <= ALUResultIn;
      MemReadOut <= MemRead;
      MemWriteOut <= MemWrite;
      MemToRegOut <= MemToReg;
      RegWriteOut <= RegWrite;
      TargetRegOut <= TargetRegIn;
      ReadData2Out <= ReadData2In;
    end if ;
  end process ; -- EX_MEM
end architecture ;
