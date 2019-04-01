library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity EX_MEM is
  port (
    Clock           : in std_logic;
    Reset           : in std_logic;

<<<<<<< HEAD:Pipeline/EX_MEM.vhd
    -- ALU signals
    ALUResultIn     : in std_logic_vector(31 downto 0);
    ALUResultOut    : out std_logic_vector(31 downto 0);

    -- Register Data
    ReadData2_In   : in std_logic_vector(31 downto 0);
    ReadData2_Out  : out std_logic_vector(31 downto 0);
    
=======
    ALUResultIn     : in std_logic_vector(31 downto 0) ;
    ReadData2In     : in std_logic_vector(31 downto 0) ;
<<<<<<< HEAD:Pipeline/EX_MEM.vhd
    TargetRegIn        : in std_logic_vector(4 downto 0) ; -- from mux of rt&rd
>>>>>>> 4bf62585c89b45a32d6f849237f3a233e9be0575:EX_MEM.vhd
=======
    TargetRegIn     : in std_logic_vector(4 downto 0) ; -- from mux of rt&rd
>>>>>>> 62f6d0c445844a1b653432502596c52d775e6468:EX_MEM.vhd

    -- MEM signals
    MemReadIn       : in std_logic;
    MemWriteIn      : in std_logic;
    MemWriteOut     : out std_logic;
    MemReadOut      : out std_logic;

    -- WB signals
    MemToReg        : in std_logic;
<<<<<<< HEAD:Pipeline/EX_MEM.vhd
<<<<<<< HEAD:Pipeline/EX_MEM.vhd
    RegDst          : in std_logic;   
=======
    RegWrite          : in std_logic;
=======
    RegWrite        : in std_logic;
>>>>>>> 62f6d0c445844a1b653432502596c52d775e6468:EX_MEM.vhd

    ALUResultOut    : out std_logic_vector(31 downto 0) ;
    ReadData2Out    : out std_logic_vector(31 downto 0) ; -- to DM WriteData
    TargetRegOut    : out std_logic_vector(4 downto 0) ; -- to Reg
    MemReadOut      : out std_logic;
    MemWriteOut     : out std_logic;
>>>>>>> 4bf62585c89b45a32d6f849237f3a233e9be0575:EX_MEM.vhd
    MemToRegOut     : out std_logic;
    RegWriteOut     : out std_logic
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
