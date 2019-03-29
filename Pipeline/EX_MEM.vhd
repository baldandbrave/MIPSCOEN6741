library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity EX_MEM is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;

    -- ALU signals
    ALUResultIn     : in std_logic_vector(31 downto 0);
    ALUResultOut    : out std_logic_vector(31 downto 0);

    -- Register Data
    ReadData2_In   : in std_logic_vector(31 downto 0);
    ReadData2_Out  : out std_logic_vector(31 downto 0);
    

    -- MEM signals
    MemReadIn       : in std_logic;
    MemWriteIn      : in std_logic;
    MemWriteOut     : out std_logic;
    MemReadOut      : out std_logic;

    -- WB signals
    MemToReg        : in std_logic;
    RegDst          : in std_logic;   
    MemToRegOut     : out std_logic;
    RegDstOut       : out std_logic
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